import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core_providers.dart';
import '../../../core/local_auth_service.dart';
import '../../../core/auth_failure.dart';
import '../domain/device_auth_repository.dart';

part 'device_auth_view_model.g.dart';

@riverpod
class DeviceAuthViewModel extends _$DeviceAuthViewModel {
  @override
  FutureOr<AuthCapabilities> build() async {
    final localAuthService = ref.watch(localAuthServiceProvider);
    return localAuthService.getCapabilities();
  }

  Future<Either<AuthFailure, Unit>> authenticate() async {
    final repository = ref.read(deviceAuthRepositoryProvider);
    return repository.authenticateWithDevice();
  }
}