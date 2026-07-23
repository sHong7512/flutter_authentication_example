import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/secure_storage_service.dart';
import '../../../core/auth_failure.dart';
import '../domain/local_pin_repository.dart';

class LocalPinRepositoryImpl implements LocalPinRepository {
  final SecureStorageService _storageService;

  LocalPinRepositoryImpl(this._storageService);

  static const int maxFailures = 5;
  static const int lockoutMinutes = 5;

  @override
  Future<Either<AuthFailure, Unit>> authenticateWithLocalPin(String pin) async {
    try {
      final failureCount = await _storageService.getFailureCount();
      if (failureCount >= maxFailures) {
        final lastFailureTime = await _storageService.getLastFailureTime();
        if (lastFailureTime != null) {
          final diff = DateTime.now().difference(lastFailureTime);
          if (diff.inMinutes < lockoutMinutes) {
            return left(const AuthFailure.lockedOut());
          } else {
            await resetLockout();
          }
        }
      }

      final storedHash = await _storageService.getPinHash();
      final inputHash = _hashPin(pin);

      if (storedHash == inputHash) {
        await resetLockout();
        return right(unit);
      } else {
        final newCount = failureCount + 1;
        await _storageService.setFailureCount(newCount);
        await _storageService.setLastFailureTime(DateTime.now());
        
        if (newCount >= maxFailures) {
          return left(const AuthFailure.lockedOut());
        }
        return left(const AuthFailure.pinMismatch());
      }
    } catch (e) {
      return left(AuthFailure.systemError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerLocalPin(String pin) async {
    try {
      final hash = _hashPin(pin);
      await _storageService.savePinHash(hash);
      await resetLockout();
      return right(unit);
    } catch (e) {
      return left(AuthFailure.systemError(e.toString()));
    }
  }

  @override
  Future<void> resetLockout() async {
    await _storageService.setFailureCount(0);
  }

  @override
  Future<bool> hasRegisteredPin() async {
    // 내부적으로 Hash를 가져오지만, 외부(UI)로는 단순히 bool 값만 반환하여 정보 은닉
    final hash = await _storageService.getPinHash();
    return hash != null;
  }

  @override
  Future<Either<AuthFailure, Unit>> modifyLocalPin(String newPin) async {
    try {
      final hash = _hashPin(newPin);
      await _storageService.savePinHash(hash);
      await resetLockout();
      return right(unit);
    } catch (e) {
      return left(AuthFailure.systemError(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> removeLocalPin() async {
    try {
      await _storageService.deletePinHash();
      await resetLockout();
      return right(unit);
    } catch (e) {
      return left(AuthFailure.systemError(e.toString()));
    }
  }

  String _hashPin(String pin) {
    const salt = "AUTH_EXAMPLE_SECURE_SALT_2024";
    final bytes = utf8.encode(pin + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
