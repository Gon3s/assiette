import 'package:assiette/data/db/enums/migraine_laterality.dart';
import 'package:assiette/data/db/enums/migraine_location.dart';

/// One timestamped observation within a migraine episode.
class MigraineObservation {
  /// Creates an immutable observation.
  const MigraineObservation({
    required this.id,
    required this.migraineId,
    required this.timestamp,
    required this.intensity,
    this.laterality,
    this.location,
    this.aura,
    this.nausea,
    this.photophobia,
    this.phonophobia,
    this.note,
  });

  /// Stable measurement id.
  final String id;

  /// Parent migraine episode id.
  final String migraineId;

  /// Time at which the user observed these characteristics.
  final DateTime timestamp;

  /// Pain intensity from 0 to 10.
  final int intensity;

  /// Affected side, or `null` when unknown.
  final MigraineLaterality? laterality;

  /// Main pain location, or `null` when unknown.
  final MigraineLocation? location;

  /// Presence of aura; `null` means unknown, `false` confirmed absence.
  final bool? aura;

  /// Presence of nausea; `null` means unknown, `false` confirmed absence.
  final bool? nausea;

  /// Presence of photophobia; `null` means unknown, `false` confirmed absence.
  final bool? photophobia;

  /// Presence of phonophobia; `null` means unknown, `false` confirmed absence.
  final bool? phonophobia;

  /// Optional free-form context.
  final String? note;
}

/// Editable values used to create or update a [MigraineObservation].
class MigraineObservationInput {
  /// Creates an observation input.
  const MigraineObservationInput({
    required this.timestamp,
    required this.intensity,
    this.laterality,
    this.location,
    this.aura,
    this.nausea,
    this.photophobia,
    this.phonophobia,
    this.note,
  });

  /// Observation time.
  final DateTime timestamp;

  /// Pain intensity from 0 to 10.
  final int intensity;

  /// Affected side, or `null` when unknown.
  final MigraineLaterality? laterality;

  /// Main pain location, or `null` when unknown.
  final MigraineLocation? location;

  /// Aura state (`null` unknown).
  final bool? aura;

  /// Nausea state (`null` unknown).
  final bool? nausea;

  /// Photophobia state (`null` unknown).
  final bool? photophobia;

  /// Phonophobia state (`null` unknown).
  final bool? phonophobia;

  /// Optional free-form context.
  final String? note;
}
