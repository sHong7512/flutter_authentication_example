import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/auth_failure.dart';
import '../../../core/local_auth_service.dart';
import '../domain/device_auth_repository.dart';

class DeviceAuthRepositoryImpl implements DeviceAuthRepository {
  final LocalAuthService _localAuthService;

  DeviceAuthRepositoryImpl(this._localAuthService);

  @override
  Future<Either<AuthFailure, Unit>> authenticateWithDevice() async {
    try {
      final authenticated = await _localAuthService.authenticate();
      if (authenticated) {
        return right(unit);
      } else {
        return left(const AuthFailure.canceledByUser());
      }
    } on PlatformException catch (e) {
      if (e.code == 'NotEnrolled') {
        return left(const AuthFailure.notEnrolled());
      } else if (e.code == 'LockedOut') {
        return left(const AuthFailure.lockedOut());
      } else if (e.code == 'PermanentlyLockedOut') {
        return left(const AuthFailure.permanentlyLockedOut());
      } else {
        return left(AuthFailure.systemError(e.message));
      }
    } catch (e) {
      return left(AuthFailure.systemError(e.toString()));
    }
  }
}
