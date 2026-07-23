import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core_providers.dart';
import '../../../core/auth_failure.dart';
import '../data/device_auth_repository_impl.dart';

part 'device_auth_repository.g.dart';

abstract class DeviceAuthRepository {
  Future<Either<AuthFailure, Unit>> authenticateWithDevice();
}

@riverpod
DeviceAuthRepository deviceAuthRepository(Ref ref) {
  final localAuthService = ref.watch(localAuthServiceProvider);
  return DeviceAuthRepositoryImpl(localAuthService);
}
