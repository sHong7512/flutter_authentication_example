import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/core_providers.dart';
import '../data/local_pin_repository_impl.dart';
import '../../../core/auth_failure.dart';

part 'local_pin_repository.g.dart';

abstract class LocalPinRepository {
  Future<Either<AuthFailure, Unit>> authenticateWithLocalPin(String pin);
  Future<Either<AuthFailure, Unit>> registerLocalPin(String pin);
  Future<Either<AuthFailure, Unit>> modifyLocalPin(String newPin);
  Future<Either<AuthFailure, Unit>> removeLocalPin();
  Future<void> resetLockout();
  Future<bool> hasRegisteredPin();
}

@riverpod
LocalPinRepository localPinRepository(Ref ref) {
  final storageService = ref.watch(storageServiceProvider);
  return LocalPinRepositoryImpl(storageService);
}