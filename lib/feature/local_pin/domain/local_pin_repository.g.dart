// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_pin_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localPinRepository)
final localPinRepositoryProvider = LocalPinRepositoryProvider._();

final class LocalPinRepositoryProvider
    extends
        $FunctionalProvider<
          LocalPinRepository,
          LocalPinRepository,
          LocalPinRepository
        >
    with $Provider<LocalPinRepository> {
  LocalPinRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localPinRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localPinRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocalPinRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalPinRepository create(Ref ref) {
    return localPinRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalPinRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalPinRepository>(value),
    );
  }
}

String _$localPinRepositoryHash() =>
    r'79d5b31634d91508ae161568dfd70dd88575ccc0';
