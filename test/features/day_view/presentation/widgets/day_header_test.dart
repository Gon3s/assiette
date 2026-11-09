import 'dart:async';

import 'package:assiette/features/day_view/domain/weather_summary.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/widgets/day_header.dart';
import 'package:assiette/features/day_view/presentation/widgets/weather_chart_sheet.dart';
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
    WeatherSummary? weather,
    String? locality,
    double textScale = 1,
    bool disableAnimations = false,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dayWeatherProvider(date).overrideWith(
            (ref) => Stream.value(
              weather ??
                  WeatherSummary(timestamp: date, pm25: pm25, pm10: pm10),
            ),
          ),
          dayLocalityProvider(date).overrideWith((ref) async => locality),
          dayWeatherSeriesProvider(date).overrideWith(
            (_) => Stream.value([]),
          ),
        ],
        child: MaterialApp(
          locale: locale,
          supportedLocales: const [Locale('fr'), Locale('en')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(textScale),
              disableAnimations: disableAnimations,
            ),
            child: child!,
          ),
          home: Scaffold(body: DayHeader(date: date)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

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
              find.text(strings.weatherAirLabel).hitTestable(),
              hasPm25 ? findsOneWidget : findsNothing,
            );
            expect(
              find.text(strings.weatherAirPm10Label).hitTestable(),
              hasPm10 && !hasPm25 ? findsOneWidget : findsNothing,
            );
            expect(
              find.byKey(const Key('weather-metrics')),
              hasPm25 && hasPm10 ? findsOneWidget : findsNothing,
            );
            if (hasPm25) {
              expect(
                find.text('4 µg/m³').hitTestable(),
                findsOneWidget,
              );
            }
            if (hasPm10) {
              if (hasPm25) {
                await tester.drag(
                  find.byKey(const Key('weather-metrics')),
                  const Offset(0, -60),
                );
                await tester.pumpAndSettle();
              }
              expect(
                find.text('13 µg/m³').hitTestable(),
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
        expect(find.byKey(const Key('weather-metrics')), findsNothing);
        expect(
          find.text('0 µg/m³'),
          findsOneWidget,
        );
      });
    });
  }

  testWidgets(
    'vertical swipes reach every available metric in both directions',
    (
      tester,
    ) async {
      await pumpHeader(
        tester,
        locale: const Locale('en'),
        weather: WeatherSummary(
          timestamp: date,
          temperature: 21,
          pressure: 1009,
          humidity: 60,
          uvIndex: 3,
          pollenMax: 20,
          pm25: 4,
          pm10: 13,
        ),
      );
      final pager = find.byKey(const Key('weather-metrics'));
      final height = tester.getSize(find.byType(DayHeader)).height;
      const values = [
        '21°C',
        '1009 hPa',
        '60 %',
        '3',
        'Moderate',
        '4 µg/m³',
        '13 µg/m³',
      ];
      for (var index = 0; index < values.length; index++) {
        expect(find.text(values[index]).hitTestable(), findsOneWidget);
        expect(tester.getSize(find.byType(DayHeader)).height, height);
        if (index < values.length - 1) {
          await tester.drag(pager, const Offset(0, -60));
          await tester.pumpAndSettle();
        }
      }
      await tester.drag(pager, const Offset(0, 60));
      await tester.pumpAndSettle();
      expect(find.text('4 µg/m³').hitTestable(), findsOneWidget);
    },
  );

  testWidgets('next button cycles metrics with reduced motion enabled', (
    tester,
  ) async {
    await pumpHeader(
      tester,
      locale: const Locale('en'),
      pm25: 4,
      pm10: 13,
      disableAnimations: true,
    );
    await tester.tap(find.byTooltip('Next weather indicator (1/2)'));
    await tester.pump();
    expect(find.text('13 µg/m³').hitTestable(), findsOneWidget);
    await tester.tap(find.byTooltip('Next weather indicator (2/2)'));
    await tester.pump();
    expect(find.text('4 µg/m³').hitTestable(), findsOneWidget);
  });

  for (final kind in WeatherChartKind.values) {
    testWidgets('tapping ${kind.name} opens its chart', (tester) async {
      await pumpHeader(
        tester,
        locale: const Locale('en'),
        weather: WeatherSummary(
          timestamp: date,
          temperature: 21,
          pressure: 1009,
        ),
      );
      if (kind == WeatherChartKind.pressure) {
        await tester.tap(find.byTooltip('Next weather indicator (1/2)'));
        await tester.pumpAndSettle();
      }
      await tester.tap(
        find.text(kind == WeatherChartKind.temperature ? '21°C' : '1009 hPa'),
      );
      await tester.pumpAndSettle();
      expect(
        tester.widget<WeatherChartSheet>(find.byType(WeatherChartSheet)).kind,
        kind,
      );
    });
  }

  testWidgets('locality is available by tapping the weather icon', (
    tester,
  ) async {
    await pumpHeader(
      tester,
      locale: const Locale('fr'),
      pm10: 13,
      locality: 'Lyon',
    );
    await tester.tap(find.byIcon(Icons.cloud_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Lyon'), findsOneWidget);
  });

  testWidgets('fits a narrow display with large text', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pumpHeader(
      tester,
      locale: const Locale('fr'),
      pm25: 4,
      pm10: 13,
      textScale: 3,
    );
    expect(tester.takeException(), isNull);
    await tester.drag(
      find.byKey(const Key('weather-metrics')),
      const Offset(0, -100),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('13 µg/m³').hitTestable(), findsOneWidget);
  });

  testWidgets('a removed metric resets the pager to an available metric', (
    tester,
  ) async {
    final weather = StreamController<WeatherSummary?>();
    addTearDown(weather.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dayWeatherProvider(date).overrideWith((_) => weather.stream),
          dayLocalityProvider(date).overrideWith((_) async => null),
        ],
        child: MaterialApp(
          home: Scaffold(body: DayHeader(date: date)),
        ),
      ),
    );
    weather.add(
      WeatherSummary(timestamp: date, temperature: 21, pm25: 4, pm10: 13),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Next weather indicator (1/3)'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Next weather indicator (2/3)'));
    await tester.pumpAndSettle();
    expect(find.text('13 µg/m³').hitTestable(), findsOneWidget);

    weather.add(WeatherSummary(timestamp: date, temperature: 22, pm25: 5));
    await tester.pumpAndSettle();
    expect(find.text('22°C').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
