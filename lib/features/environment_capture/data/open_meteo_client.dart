import 'dart:convert';

import 'package:assiette/features/environment_capture/domain/air_quality_reading.dart';
import 'package:assiette/features/environment_capture/domain/hourly_measure.dart';
import 'package:assiette/features/environment_capture/domain/open_meteo_hourly_history.dart';
import 'package:assiette/features/environment_capture/domain/open_meteo_reading.dart';
import 'package:http/http.dart' as http;

/// Thrown when the Open-Meteo API returns an unexpected response.
class OpenMeteoException implements Exception {
  /// Creates an [OpenMeteoException] with the given [message].
  OpenMeteoException(this.message);

  /// Human-readable description of the failure.
  final String message;

  @override
  String toString() => 'OpenMeteoException: $message';
}

/// Fetches current weather/pressure conditions from the Open-Meteo API.
///
/// Open-Meteo (https://open-meteo.com/) requires no API key; its data is
/// published under CC BY 4.0.
class OpenMeteoClient {
  /// Creates an [OpenMeteoClient], optionally injecting an [http.Client]
  /// for testing.
  OpenMeteoClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';
  static const _airQualityBaseUrl =
      'https://air-quality-api.open-meteo.com/v1/air-quality';
  static const _currentFields =
      'pressure_msl,surface_pressure,temperature_2m,relative_humidity_2m,'
      'weather_code,uv_index';
  static const _airQualityCurrentFields =
      'pm2_5,pm10,alder_pollen,birch_pollen,grass_pollen,mugwort_pollen,'
      'olive_pollen,ragweed_pollen';
  static const _hourlyHistoryFields =
      'pressure_msl,temperature_2m,relative_humidity_2m,weather_code,'
      'uv_index';

  final http.Client _httpClient;

  /// Fetches the current conditions at the given coordinates.
  Future<OpenMeteoReading> fetchCurrent({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': _currentFields,
      },
    );

    final response = await _httpClient.get(uri);
    if (response.statusCode != 200) {
      throw OpenMeteoException(
        'Unexpected status code ${response.statusCode}',
      );
    }

    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      throw OpenMeteoException('Unexpected response body');
    }
    final current = body['current'];
    if (current is! Map<String, dynamic>) {
      throw OpenMeteoException('Missing "current" block');
    }

    return OpenMeteoReading(
      pressure: _asDouble(current['pressure_msl']),
      surfacePressure: _asDouble(current['surface_pressure']),
      temperature: _asDouble(current['temperature_2m']),
      humidity: _asDouble(current['relative_humidity_2m']),
      weatherCode: _asInt(current['weather_code']),
      uvIndex: _asDouble(current['uv_index']),
    );
  }

  /// Fetches the current air quality (particulates + pollen) at the given
  /// coordinates. Missing fields are returned as `null` (pollen is only
  /// available over Europe).
  Future<AirQualityReading> fetchCurrentAirQuality({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(_airQualityBaseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': _airQualityCurrentFields,
      },
    );

    final current = _currentBlock(await _httpClient.get(uri));
    return AirQualityReading(
      pm25: _asDouble(current['pm2_5']),
      pm10: _asDouble(current['pm10']),
      alderPollen: _asDouble(current['alder_pollen']),
      birchPollen: _asDouble(current['birch_pollen']),
      grassPollen: _asDouble(current['grass_pollen']),
      mugwortPollen: _asDouble(current['mugwort_pollen']),
      olivePollen: _asDouble(current['olive_pollen']),
      ragweedPollen: _asDouble(current['ragweed_pollen']),
    );
  }

  /// Fetches the hourly weather series covering the past [pastDays] days
  /// plus today, in the local timezone of the coordinates.
  Future<OpenMeteoHourlyHistory> fetchHourlyHistory({
    required double latitude,
    required double longitude,
    required int pastDays,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'hourly': _hourlyHistoryFields,
        'past_days': pastDays.toString(),
        'forecast_days': '1',
        'timezone': 'auto',
      },
    );

    final hourly = _hourlyBlock(await _httpClient.get(uri));
    final times = hourly['time'];
    if (times is! List) {
      throw OpenMeteoException('Missing "time" series');
    }

    List<double?> doubles(String key) {
      final values = hourly[key];
      if (values is! List) return List.filled(times.length, null);
      return [for (final value in values) _asDouble(value)];
    }

    return OpenMeteoHourlyHistory(
      // Strict parse: a non-string entry would silently desync the parallel
      // value lists, so let it throw instead.
      times: [for (final value in times) DateTime.parse(value as String)],
      pressure: doubles('pressure_msl'),
      temperature: doubles('temperature_2m'),
      humidity: doubles('relative_humidity_2m'),
      weatherCode: [
        for (final value in (hourly['weather_code'] is List
            ? hourly['weather_code'] as List
            : List<Object?>.filled(times.length, null)))
          _asInt(value),
      ],
      uvIndex: doubles('uv_index'),
    );
  }

  /// Fetches the hourly pressure forecast (hPa) with timestamps, covering
  /// today and tomorrow in the local timezone of the coordinates.
  Future<List<HourlyMeasure>> fetchPressureForecastSeries({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'hourly': 'pressure_msl',
        'forecast_days': '2',
        'timezone': 'auto',
      },
    );

    final hourly = _hourlyBlock(await _httpClient.get(uri));
    final times = hourly['time'];
    final pressures = hourly['pressure_msl'];
    if (times is! List || pressures is! List) {
      throw OpenMeteoException('Missing "time" or "pressure_msl" series');
    }

    final length =
        times.length < pressures.length ? times.length : pressures.length;
    return [
      for (var i = 0; i < length; i++)
        if (times[i] is String && pressures[i] is num)
          HourlyMeasure(
            time: DateTime.parse(times[i] as String),
            value: (pressures[i] as num).toDouble(),
          ),
    ];
  }

  /// Fetches hourly pressure forecast (hPa) at the given coordinates, one
  /// value per hour starting from the current hour, covering the next 48h.
  Future<List<double>> fetchPressureForecast({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'hourly': 'pressure_msl',
        'forecast_days': '2',
      },
    );

    final response = await _httpClient.get(uri);
    if (response.statusCode != 200) {
      throw OpenMeteoException(
        'Unexpected status code ${response.statusCode}',
      );
    }

    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      throw OpenMeteoException('Unexpected response body');
    }
    final hourly = body['hourly'];
    if (hourly is! Map<String, dynamic>) {
      throw OpenMeteoException('Missing "hourly" block');
    }
    final pressures = hourly['pressure_msl'];
    if (pressures is! List) {
      throw OpenMeteoException('Missing "pressure_msl" series');
    }

    return [
      for (final value in pressures)
        if (value is num) value.toDouble(),
    ];
  }

  static double? _asDouble(Object? value) =>
      value is num ? value.toDouble() : null;

  static int? _asInt(Object? value) => value is num ? value.toInt() : null;

  /// Decodes [response] and returns its `current` block, or throws.
  static Map<String, dynamic> _currentBlock(http.Response response) =>
      _block(response, 'current');

  /// Decodes [response] and returns its `hourly` block, or throws.
  static Map<String, dynamic> _hourlyBlock(http.Response response) =>
      _block(response, 'hourly');

  static Map<String, dynamic> _block(http.Response response, String key) {
    if (response.statusCode != 200) {
      throw OpenMeteoException(
        'Unexpected status code ${response.statusCode}',
      );
    }
    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      throw OpenMeteoException('Unexpected response body');
    }
    final block = body[key];
    if (block is! Map<String, dynamic>) {
      throw OpenMeteoException('Missing "$key" block');
    }
    return block;
  }
}
