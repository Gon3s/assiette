import 'package:assiette/features/environment_capture/data/locality_resolver.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:mocktail/mocktail.dart';

class _MockGeocoding extends Mock implements geocoding.Geocoding {}

void main() {
  late _MockGeocoding geocoder;
  late GeocodingLocalityResolver resolver;

  setUp(() {
    geocoder = _MockGeocoding();
    resolver = GeocodingLocalityResolver(geocoder: geocoder);
  });

  test(
    'resolves a locality through the geocoding 5 client and caches its zone',
    () async {
      when(() => geocoder.placemarkFromCoordinates(any(), any())).thenAnswer(
        (_) async => [const geocoding.Placemark(locality: 'Lyon')],
      );
      expect(
        await resolver.resolveLocality(latitude: 45.751, longitude: 4.851),
        'Lyon',
      );
      expect(
        await resolver.resolveLocality(latitude: 45.752, longitude: 4.852),
        'Lyon',
      );
      verify(() => geocoder.placemarkFromCoordinates(45.751, 4.851)).called(1);
      verifyNoMoreInteractions(geocoder);
    },
  );

  for (final placemark in [
    const geocoding.Placemark(locality: '', subAdministrativeArea: 'Rhône'),
    const geocoding.Placemark(administrativeArea: 'Rhône'),
  ]) {
    test('falls back to a known administrative area for $placemark', () async {
      when(() => geocoder.placemarkFromCoordinates(any(), any()))
          .thenAnswer((_) async => [placemark]);
      expect(
        await resolver.resolveLocality(latitude: 45.75, longitude: 4.85),
        'Rhône',
      );
    });
  }

  test('returns null for empty results and platform failures', () async {
    when(() => geocoder.placemarkFromCoordinates(any(), any()))
        .thenAnswer((_) async => []);
    expect(
      await resolver.resolveLocality(latitude: 45.75, longitude: 4.85),
      isNull,
    );
    when(() => geocoder.placemarkFromCoordinates(any(), any()))
        .thenThrow(PlatformException(code: 'IO_ERROR'));
    expect(
      await resolver.resolveLocality(latitude: 48.86, longitude: 2.35),
      isNull,
    );
  });

  test(
    'remains usable on platforms without a registered geocoding plugin',
    () async {
      expect(geocoding.GeocodingPlatformFactory.instance, isNull);
      expect(
        await GeocodingLocalityResolver().resolveLocality(
          latitude: 45.75,
          longitude: 4.85,
        ),
        isNull,
      );
    },
  );
}
