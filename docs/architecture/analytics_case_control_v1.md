# Analytics case/control model V1

Status: accepted design for US-28  
Algorithm version: `case_control_v1.0.0`

## Purpose

This document defines the first reproducible analytics model used to compare
the context preceding migraine episodes with comparable periods without a
migraine.

The model produces personal, descriptive associations. It does not establish
causality, diagnose a condition, or recommend dietary or treatment changes.

## Source of truth

Timestamped domain events stored in Drift remain the source of truth. Analytics
objects and results are derived data and may be rebuilt at any time.

A cached result, if introduced later, must record:

- the algorithm version;
- the complete serialized configuration;
- the computation timestamp;
- a deterministic fingerprint of the input events.

Changing a rule or default requires a new algorithm version. Historical
results must never silently adopt newer rules.

## Terminology

### Migraine episode

One migraine episode is one case. Only non-deleted migraine symptoms are
eligible.

An episode is eligible for exposure analysis when:

- it has a real `startedAt`;
- its start precision is `exact` or `approximate`;
- its start instant can be unambiguously converted to UTC.

Episodes with an unknown start remain visible in descriptive totals but are
excluded from temporal exposure calculations.

### Anchor

An anchor is the instant from which a lookback window is calculated:

- a case anchor is the migraine's real `startedAt`;
- a control anchor is a matched instant during an observed migraine-free
  period.

### Exposure state

Every factor/window evaluation has exactly one state:

- `exposed`: the factor is present;
- `notExposed`: absence is supported by sufficiently complete data;
- `unknown`: the available data cannot establish presence or absence.

`unknown` is never converted to zero and is excluded from the denominator for
that factor/window comparison.

## Time model

All comparisons use UTC instants. The event's local time zone is retained for
matching and display, including travel and daylight-saving transitions.

Windows are half-open intervals:

```text
[anchor - window duration, anchor)
```

An event occurring exactly at the migraine start is therefore never considered
a preceding exposure.

V1 defines these non-overlapping windows for discrete events:

- 0–6 hours;
- 6–12 hours;
- 12–24 hours;
- 24–48 hours.

It also permits these cumulative windows for continuous or summary factors:

- 0–6 hours;
- 0–12 hours;
- 0–24 hours;
- 0–48 hours.

The factor definition declares which window family it supports. A UI cannot
silently substitute one family for another.

## V1 factor scope

V1 only evaluates factors already collected with acceptable reliability:

- meal tags;
- previous-night sleep quality and duration when available;
- pressure level and pressure changes calculated from raw weather snapshots.

Hydration, quantified caffeine, stress, activity, alcohol, normalized foods,
and factor combinations are outside V1.

Each factor definition specifies:

- a stable identifier;
- its supported windows;
- the minimum coverage needed to call `notExposed`;
- how raw events become an exposure;
- units and aggregation rules when applicable.

## Observation completeness

A blank day is not automatically migraine-free or exposure-free.

Manually logged factors require explicit coverage information introduced by
US-33. A control window is eligible for a manual factor only when its complete
lookback period is confirmed sufficiently observed.

Automatically collected factors use source-specific coverage rules. For
weather, a window is `unknown` when there are not enough raw measurements to
compute the requested value without extrapolation.

Completeness is evaluated per factor. Missing hydration data, for example,
must not invalidate an otherwise complete pressure comparison.

Until US-33 is implemented, V1 results may be exercised with fixtures and
development data but must not be presented as production insights.

## Control selection

V1 selects up to four controls per eligible case.

### Candidate requirements

A control candidate:

- uses the same local wall-clock time as its case;
- lies within 30 days before or after the case;
- has sufficient observation coverage for the evaluated factor and window;
- does not overlap an exclusion period from any migraine;
- is not reused for the same case and factor/window.

Candidates on the same weekday are preferred. If fewer than four exist, V1
may use other weekdays with the same local time.

### Migraine exclusion period

For each migraine, controls are excluded when their 48-hour lookback window or
anchor intersects:

```text
[migraine.startedAt - 48 hours, migraine effective end + 24 hours]
```

The effective end is `endedAt` when present. Otherwise it is
`startedAt + 24 hours`.

The 24-hour post-episode exclusion is an algorithm configuration value, not a
database or UI constant.

### Deterministic ordering

Candidates are ordered by:

1. same weekday before other weekdays;
2. absolute calendar distance from the case;
3. earlier instant before later instant when distances tie;
4. stable event identifier as the final tie-breaker.

The first four eligible candidates are selected. Identical inputs and
configuration must always select the same controls.

## Association counts

For one factor and one window:

```text
a = eligible cases exposed
b = eligible cases not exposed
c = eligible controls exposed
d = eligible controls not exposed
```

Unknown evaluations are reported separately and excluded from `a`, `b`,
`c`, and `d`.

```text
case exposure rate    = a / (a + b)
control exposure rate = c / (c + d)
risk ratio            = case rate / control rate
absolute difference   = case rate - control rate
```

No risk ratio is displayed when the control rate is zero. The UI displays the
raw counts and explains that the ratio is undefined.

Controls are not presented as independent people or population-level evidence.
Results are explicitly described as within-person observations.

## Display thresholds

Thresholds are product safeguards, not medical thresholds.

### Data sufficiency

- fewer than 5 eligible cases: `insufficientData`;
- 5–9 eligible cases: `exploratory`;
- 10–19 eligible cases: eligible for `possibleAssociation`;
- 20 or more eligible cases: eligible for `markedAssociation`.

At least two valid controls per eligible case and ten controls in total are
required. Otherwise the result is `insufficientData`.

### Signal classification

A factor is `noSignalDetected` when either:

- the absolute exposure-rate difference is below 0.10; or
- the risk ratio is between 0.67 and 1.50.

An `exploratory` result requires 5–9 eligible cases and a ratio outside that
neutral range.

A `possibleAssociation` requires:

- at least 10 eligible cases;
- an absolute difference of at least 0.15;
- a risk ratio of at least 1.50, or at most 0.67.

A `markedAssociation` requires:

- at least 20 eligible cases;
- at least 5 exposed cases;
- an absolute difference of at least 0.25;
- a risk ratio of at least 2.00, or at most 0.50.

The exact counts, rates, window, unknown count, and algorithm version are always
shown. A label never replaces the evidence.

## Multiple comparisons

V1 does not calculate p-values and does not test arbitrary factor
combinations.

Only predeclared factors and windows may be evaluated. Results may be sorted
for navigation, but the UI must explain that evaluating several factors
increases the chance of coincidental signals.

Formal multiple-testing correction, confidence intervals, Fisher's exact test,
and regression belong to US-53 and require a new algorithm version.

## Language rules

Allowed:

> This factor appeared more frequently before your migraines than during
> matched migraine-free periods.

Not allowed:

> This factor triggers your migraines.

The UI must never recommend excluding food, changing medication, or delaying
medical care from an association result.

## Configuration contract

The V1 configuration is immutable once released and contains at least:

```text
algorithmVersion: case_control_v1.0.0
maximumControlsPerCase: 4
maximumControlDistanceDays: 30
postMigraineExclusionHours: 24
fallbackEpisodeDurationHours: 24
maximumLookbackHours: 48
discreteWindowsHours: [0-6, 6-12, 12-24, 24-48]
cumulativeWindowsHours: [0-6, 0-12, 0-24, 0-48]
minimumCases: 5
minimumControlsPerCase: 2
minimumTotalControls: 10
```

Configuration serialization uses stable key ordering. Any semantic change,
including thresholds or candidate ordering, requires a version increment.

## Required reference scenarios

Implementations of US-34 through US-37 must cover these fixtures:

1. A meal at the migraine start is excluded.
2. A meal one millisecond before the start is included.
3. An unknown factor is excluded from the denominator.
4. A frequently consumed factor has similar case and control rates and
   produces no signal.
5. A control whose lookback overlaps a migraine exclusion period is rejected.
6. Same-weekday controls are selected before other weekdays.
7. Candidate selection is deterministic across repeated runs.
8. Four migraines always produce `insufficientData`.
9. A zero control rate produces counts but no numeric risk ratio.
10. Changing the configuration version cannot overwrite a cached result from
    another version.
11. Soft-deleted events never contribute to an exposure.
12. DST and travel fixtures compare UTC instants while matching local time.

## Deferred decisions

These decisions are explicitly outside V1:

- exact statistical confidence intervals;
- correction for multiple testing;
- combined-factor analysis;
- adaptive or personalized windows;
- population-level comparisons;
- causal inference;
- automatic health recommendations.

They require separate tickets, evidence, and an algorithm version change.

## Downstream ticket contract

- US-29 must provide an eligible migraine start and precision.
- US-33 must provide factor-aware observation completeness.
- US-34 must implement the window boundaries exactly as specified.
- US-35 must implement deterministic matched-control selection.
- US-36 must implement counts, rates, thresholds, and language rules.
- US-37 must expose evidence and algorithm version in the UI and tests.

