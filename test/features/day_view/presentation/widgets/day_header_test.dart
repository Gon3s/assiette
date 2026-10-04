import 'package:assiette/common_widgets/stat_tile_card.dart';
import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/widgets/day_header.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final date = DateTime(2025, 1, 15);

  Future<void> pumpHeader(
    WidgetTester tester, {
    required Locale locale,
    double? pm25,
    double? pm10,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dayWeatherProvider(date).overrideWith(
            (ref) => Stream.value(
              WeatherSummary(timestamp: date, pm25: pm25, pm10: pm10),
            ),
          ),
          dayLocalityProvider(date).overrideWith((ref) async => null),
        ],
        child: MaterialApp(
          locale: locale,
          supportedLocales: const [Locale('fr'), Locale('en')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: Scaffold(body: DayHeader(date: date)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder tileWithLabel(String label) => find.ancestor(
    of: find.text(label),
    matching: find.byType(StatTileCard),
  );

  for (final locale in [const Locale('fr'), const Locale('en')]) {
    group('DayHeader air tiles (${locale.languageCode})', () {
      final strings = AppStrings.ofLocale(locale);

      for (final hasPm25 in [false, true]) {
        for (final hasPm10 in [false, true]) {
          testWidgets('PM2.5=$hasPm25, PM10=$hasPm10', (tester) async {
            await pumpHeader(
              tester,
              locale: locale,
              pm25: hasPm25 ? 4.2 : null,
              pm10: hasPm10 ? 12.6 : null,
            );

            expect(strings.weatherAirPm10Label, 'Air (PM10)');
            expect(
              tileWithLabel(strings.weatherAirLabel),
              hasPm25 ? findsOneWidget : findsNothing,
            );
            expect(
              tileWithLabel(strings.weatherAirPm10Label),
              hasPm10 ? findsOneWidget : findsNothing,
            );
            expect(
              find.byType(StatTileCard),
              findsNWidgets((hasPm25 ? 1 : 0) + (hasPm10 ? 1 : 0)),
            );
            if (hasPm25) {
              expect(
                find.descendant(
                  of: tileWithLabel(strings.weatherAirLabel),
                  matching: find.text('4 µg/m³'),
                ),
                findsOneWidget,
              );
            }
            if (hasPm10) {
              expect(
                find.descendant(
                  of: tileWithLabel(strings.weatherAirPm10Label),
                  matching: find.text('13 µg/m³'),
                ),
                findsOneWidget,
              );
            }
          });
        }
      }

      testWidgets('shows zero PM10 without PM2.5', (tester) async {
        await pumpHeader(tester, locale: locale, pm10: 0);

        expect(find.text('Air (PM10)'), findsOneWidget);
        expect(find.text(strings.weatherAirLabel), findsNothing);
        expect(find.byType(StatTileCard), findsOneWidget);
        expect(
          find.descendant(
            of: tileWithLabel(strings.weatherAirPm10Label),
            matching: find.text('0 µg/m³'),
          ),
          findsOneWidget,
        );
      });
    });
  }
}
