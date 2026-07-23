// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_auth_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeviceAuthViewModel)
final deviceAuthViewModelProvider = DeviceAuthViewModelProvider._();

final class DeviceAuthViewModelProvider
    extends $AsyncNotifierProvider<DeviceAuthViewModel, AuthCapabilities> {
  DeviceAuthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceAuthViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceAuthViewModelHash();

  @$internal
  @override
  DeviceAuthViewModel create() => DeviceAuthViewModel();
}

String _$deviceAuthViewModelHash() =>
    r'2d8395ad96b2988562ea998ec4702bbf0f27e226';

abstract class _$DeviceAuthViewModel extends $AsyncNotifier<AuthCapabilities> {
  FutureOr<AuthCapabilities> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AuthCapabilities>, AuthCapabilities>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthCapabilities>, AuthCapabilities>,
              AsyncValue<AuthCapabilities>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
