// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_pin_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalPinViewModel)
final localPinViewModelProvider = LocalPinViewModelProvider._();

final class LocalPinViewModelProvider
    extends $AsyncNotifierProvider<LocalPinViewModel, bool> {
  LocalPinViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localPinViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localPinViewModelHash();

  @$internal
  @override
  LocalPinViewModel create() => LocalPinViewModel();
}

String _$localPinViewModelHash() => r'7c3c86ddd5e80a7211fca3e58f3b94a9525b9e45';

abstract class _$LocalPinViewModel extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
