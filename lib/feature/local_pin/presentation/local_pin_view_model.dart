import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth_failure.dart';
import '../domain/local_pin_repository.dart';

part 'local_pin_view_model.g.dart';

@riverpod
class LocalPinViewModel extends _$LocalPinViewModel {
  @override
  FutureOr<bool> build() async {
    final repository = ref.watch(localPinRepositoryProvider);
    return repository.hasRegisteredPin();
  }

  Future<Either<AuthFailure, Unit>> registerPin(String pin) async {
    final repository = ref.read(localPinRepositoryProvider);
    final result = await repository.registerLocalPin(pin);

    if (result.isRight()) {
      state = const AsyncData(true);
    }
    return result;
  }

  Future<Either<AuthFailure, Unit>> loginWithPin(String pin) async {
    final repository = ref.read(localPinRepositoryProvider);
    return repository.authenticateWithLocalPin(pin);
  }

  Future<Either<AuthFailure, Unit>> modifyPin(String pin) async {
    final repository = ref.read(localPinRepositoryProvider);
    final result = await repository.modifyLocalPin(pin);

    if (result.isRight()) {
      state = const AsyncData(true);
    }
    return result;
  }

  Future<Either<AuthFailure, Unit>> removePin() async {
    state = const AsyncLoading();

    final repository = ref.read(localPinRepositoryProvider);
    final result = await repository.removeLocalPin();

    result.fold(
      (failure) => ref.invalidateSelf(),
      (_) => state = const AsyncData(false),
    );
    return result;
  }
}
