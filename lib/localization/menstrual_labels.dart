import 'package:assiette/features/menstrual_tracking/domain/menstrual_observation.dart';
import 'package:assiette/localization/app_strings.dart';

String bleedingStatusLabel(AppStrings s, BleedingStatus status) =>
    switch (status) {
      BleedingStatus.none => s.menstrualNone,
      BleedingStatus.spotting => s.menstrualSpotting,
      BleedingStatus.period => s.menstrualPeriod,
    };

String menstrualFlowLabel(AppStrings s, MenstrualFlow? flow) => switch (flow) {
  null => s.menstrualFlowUnknown,
  MenstrualFlow.light => s.menstrualFlowLight,
  MenstrualFlow.medium => s.menstrualFlowMedium,
  MenstrualFlow.heavy => s.menstrualFlowHeavy,
};

String menstrualSummary(AppStrings s, MenstrualObservation observation) => [
  bleedingStatusLabel(s, observation.status),
  if (observation.flow != null) menstrualFlowLabel(s, observation.flow),
  if (observation.isPeriodStart) s.menstrualStart,
].join(' · ');
