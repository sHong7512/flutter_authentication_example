// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureStorage)
final secureStorageProvider = SecureStorageProvider._();

final class SecureStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorage,
          FlutterSecureStorage,
          FlutterSecureStorage
        >
    with $Provider<FlutterSecureStorage> {
  SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return secureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$secureStorageHash() => r'c3d90388f6d1bb7c95a29ceeda2e56c57deb1ecb';

@ProviderFor(storageService)
final storageServiceProvider = StorageServiceProvider._();

final class StorageServiceProvider
    extends
        $FunctionalProvider<
          SecureStorageService,
          SecureStorageService,
          SecureStorageService
        >
    with $Provider<SecureStorageService> {
  StorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageServiceHash();

  @$internal
  @override
  $ProviderElement<SecureStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecureStorageService create(Ref ref) {
    return storageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureStorageService>(value),
    );
  }
}

String _$storageServiceHash() => r'3870272506cca7def5bff70ea66ebbd4cd98519e';

@ProviderFor(localAuthentication)
final localAuthenticationProvider = LocalAuthenticationProvider._();

final class LocalAuthenticationProvider
    extends
        $FunctionalProvider<
          LocalAuthentication,
          LocalAuthentication,
          LocalAuthentication
        >
    with $Provider<LocalAuthentication> {
  LocalAuthenticationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localAuthenticationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localAuthenticationHash();

  @$internal
  @override
  $ProviderElement<LocalAuthentication> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalAuthentication create(Ref ref) {
    return localAuthentication(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalAuthentication value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalAuthentication>(value),
    );
  }
}

String _$localAuthenticationHash() =>
    r'e51061f5b1d6a1bd524c854a0121bb35c77822d3';

@ProviderFor(localAuthService)
final localAuthServiceProvider = LocalAuthServiceProvider._();

final class LocalAuthServiceProvider
    extends
        $FunctionalProvider<
          LocalAuthService,
          LocalAuthService,
          LocalAuthService
        >
    with $Provider<LocalAuthService> {
  LocalAuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localAuthServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localAuthServiceHash();

  @$internal
  @override
  $ProviderElement<LocalAuthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalAuthService create(Ref ref) {
    return localAuthService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalAuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalAuthService>(value),
    );
  }
}

String _$localAuthServiceHash() => r'c4f14ab8ae3cee0b3c270d2a02fc45669170a5c6';
