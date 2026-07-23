// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceAuthRepository)
final deviceAuthRepositoryProvider = DeviceAuthRepositoryProvider._();

final class DeviceAuthRepositoryProvider
    extends
        $FunctionalProvider<
          DeviceAuthRepository,
          DeviceAuthRepository,
          DeviceAuthRepository
        >
    with $Provider<DeviceAuthRepository> {
  DeviceAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceAuthRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceAuthRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeviceAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceAuthRepository create(Ref ref) {
    return deviceAuthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceAuthRepository>(value),
    );
  }
}

String _$deviceAuthRepositoryHash() =>
    r'b8437899bace2956f1cc9f0b8f1c0e12ddb7726f';
