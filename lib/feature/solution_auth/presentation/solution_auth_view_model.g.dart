// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solution_auth_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SolutionAuthViewModel)
final solutionAuthViewModelProvider = SolutionAuthViewModelProvider._();

final class SolutionAuthViewModelProvider
    extends $AsyncNotifierProvider<SolutionAuthViewModel, String?> {
  SolutionAuthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'solutionAuthViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$solutionAuthViewModelHash();

  @$internal
  @override
  SolutionAuthViewModel create() => SolutionAuthViewModel();
}

String _$solutionAuthViewModelHash() =>
    r'4c734783c7510617010c4a2f8e6b1d2a24845221';

abstract class _$SolutionAuthViewModel extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
