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
            'pressure_msl,surface_pressure,temperature_2m,relative_humidity_2m',
          );
          return http.Response(
            jsonEncode({
              'current': {
                'pressure_msl': 1013.2,
                'surface_pressure': 998.1,
                'temperature_2m': 21.5,
                'relative_humidity_2m': 60,
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
