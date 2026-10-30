// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(coffeeRepository)
final coffeeRepositoryProvider = CoffeeRepositoryProvider._();

final class CoffeeRepositoryProvider
    extends
        $FunctionalProvider<
          CoffeeRepository,
          CoffeeRepository,
          CoffeeRepository
        >
    with $Provider<CoffeeRepository> {
  CoffeeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coffeeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coffeeRepositoryHash();

  @$internal
  @override
  $ProviderElement<CoffeeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CoffeeRepository create(Ref ref) {
    return coffeeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CoffeeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CoffeeRepository>(value),
    );
  }
}

String _$coffeeRepositoryHash() => r'ea6bd7c8fc4406bf8169620090c6548a6fa52686';

@ProviderFor(coffeeDay)
final coffeeDayProvider = CoffeeDayFamily._();

final class CoffeeDayProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CoffeeEntry>>,
          List<CoffeeEntry>,
          Stream<List<CoffeeEntry>>
        >
    with
        $FutureModifier<List<CoffeeEntry>>,
        $StreamProvider<List<CoffeeEntry>> {
  CoffeeDayProvider._({
    required CoffeeDayFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'coffeeDayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$coffeeDayHash();

  @override
  String toString() {
    return r'coffeeDayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<CoffeeEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CoffeeEntry>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return coffeeDay(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CoffeeDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$coffeeDayHash() => r'951275ae8a93741b029df5b22cbfc7908f6bc647';

final class CoffeeDayFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CoffeeEntry>>, DateTime> {
  CoffeeDayFamily._()
    : super(
        retry: null,
        name: r'coffeeDayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CoffeeDayProvider call(DateTime day) =>
      CoffeeDayProvider._(argument: day, from: this);

  @override
  String toString() => r'coffeeDayProvider';
}
