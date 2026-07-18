import 'dart:convert';

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
  static const _currentFields =
      'pressure_msl,surface_pressure,temperature_2m,relative_humidity_2m';

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
    );
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
}
