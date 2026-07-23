import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_auth_service.dart';
import 'secure_storage_service.dart';

part 'core_providers.g.dart';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
}

@riverpod
SecureStorageService storageService(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return SecureStorageService(storage);
}

@riverpod
LocalAuthentication localAuthentication(Ref ref) {
  return LocalAuthentication();
}

@riverpod
LocalAuthService localAuthService(Ref ref) {
  final auth = ref.watch(localAuthenticationProvider);
  return LocalAuthService(auth);
}
