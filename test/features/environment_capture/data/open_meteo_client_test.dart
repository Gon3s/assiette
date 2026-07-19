import 'dart:convert';

import 'package:assiette/features/environment_capture/data/open_meteo_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('OpenMeteoClient', () {
    test('parses the current conditions block', () async {
      final client = OpenMeteoClient(
        httpClient: MockClient((request) async {
          expect(request.url.host, 'api.open-meteo.com');
          expect(request.url.queryParameters['latitude'], '45.75');
          expect(request.url.queryParameters['longitude'], '4.85');
          expect(
            request.url.queryParameters['current'],
            'pressure_msl,surface_pressure,temperature_2m,'
            'relative_humidity_2m,weather_code,uv_index',
          );
          return http.Response(
            jsonEncode({
              'current': {
                'pressure_msl': 1013.2,
                'surface_pressure': 998.1,
                'temperature_2m': 21.5,
                'relative_humidity_2m': 60,
                'weather_code': 61,
                'uv_index': 4.2,
              },
            }),
            200,
          );
        }),
      );

      final reading = await client.fetchCurrent(
        latitude: 45.75,
        longitude: 4.85,
      );

      expect(reading.pressure, 1013.2);
      expect(reading.surfacePressure, 998.1);
      expect(reading.temperature, 21.5);
      expect(reading.humidity, 60);
      expect(reading.weatherCode, 61);
      expect(reading.uvIndex, 4.2);
    });

    test('parses the current air-quality block, tolerating missing pollen',
        () async {
      final client = OpenMeteoClient(
        httpClient: MockClient((request) async {
          expect(request.url.host, 'air-quality-api.open-meteo.com');
          return http.Response(
            jsonEncode({
              'current': {
                'pm2_5': 8.4,
                'pm10': 15.1,
                'grass_pollen': 22.0,
              },
            }),
            200,
          );
        }),
      );

      final reading = await client.fetchCurrentAirQuality(
        latitude: 45.75,
        longitude: 4.85,
      );

      expect(reading.pm25, 8.4);
      expect(reading.pm10, 15.1);
      expect(reading.grassPollen, 22.0);
      expect(reading.birchPollen, isNull);
    });

    test('parses the hourly history with parallel series', () async {
      final client = OpenMeteoClient(
        httpClient: MockClient((request) async {
          expect(request.url.queryParameters['past_days'], '2');
          expect(request.url.queryParameters['timezone'], 'auto');
          return http.Response(
            jsonEncode({
              'hourly': {
                'time': ['2026-07-17T00:00', '2026-07-17T01:00'],
                'pressure_msl': [1013.0, 1012.5],
                'temperature_2m': [18.0, null],
                'relative_humidity_2m': [70, 72],
                'weather_code': [3, 61],
                'uv_index': [0.0, 0.0],
              },
            }),
            200,
          );
        }),
      );

      final history = await client.fetchHourlyHistory(
        latitude: 45.75,
        longitude: 4.85,
        pastDays: 2,
      );

      expect(history.times, [
        DateTime(2026, 7, 17),
        DateTime(2026, 7, 17, 1),
      ]);
      expect(history.pressure, [1013.0, 1012.5]);
      expect(history.temperature, [18.0, null]);
      expect(history.weatherCode, [3, 61]);
    });

    test('parses the pressure forecast series with timestamps', () async {
      final client = OpenMeteoClient(
        httpClient: MockClient(
          (request) async => http.Response(
            jsonEncode({
              'hourly': {
                'time': ['2026-07-19T00:00', '2026-07-19T01:00'],
                'pressure_msl': [1013.0, 1011.0],
              },
            }),
            200,
          ),
        ),
      );

      final series = await client.fetchPressureForecastSeries(
        latitude: 45.75,
        longitude: 4.85,
      );

      expect(series, hasLength(2));
      expect(series.first.time, DateTime(2026, 7, 19));
      expect(series.first.value, 1013.0);
      expect(series.last.value, 1011.0);
    });

    test('throws OpenMeteoException on a non-200 response', () async {
      final client = OpenMeteoClient(
        httpClient: MockClient((request) async => http.Response('', 500)),
      );

      expect(
        () => client.fetchCurrent(latitude: 0, longitude: 0),
        throwsA(isA<OpenMeteoException>()),
      );
    });

    test('throws OpenMeteoException when the current block is missing',
        () async {
      final client = OpenMeteoClient(
        httpClient: MockClient(
          (request) async => http.Response(jsonEncode({}), 200),
        ),
      );

      expect(
        () => client.fetchCurrent(latitude: 0, longitude: 0),
        throwsA(isA<OpenMeteoException>()),
      );
    });
  });
}
