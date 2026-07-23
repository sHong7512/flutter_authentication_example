import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  static const _pinHashKey = 'pin_hash';
  static const _biometricEnabledKey = 'biometric_enabled';
  static const _failureCountKey = 'failure_count';
  static const _lastFailureTimeKey = 'last_failure_time';

  Future<void> savePinHash(String hash) async {
    await _storage.write(key: _pinHashKey, value: hash);
  }

  Future<String?> getPinHash() async {
    return await _storage.read(key: _pinHashKey);
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: _biometricEnabledKey, value: enabled.toString());
  }

  Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  Future<int> getFailureCount() async {
    final value = await _storage.read(key: _failureCountKey);
    return int.tryParse(value ?? '0') ?? 0;
  }

  Future<void> setFailureCount(int count) async {
    await _storage.write(key: _failureCountKey, value: count.toString());
  }

  Future<void> setLastFailureTime(DateTime time) async {
    await _storage.write(key: _lastFailureTimeKey, value: time.toIso8601String());
  }

  Future<DateTime?> getLastFailureTime() async {
    final value = await _storage.read(key: _lastFailureTimeKey);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  Future<void> deletePinHash() async {
    await _storage.delete(key: _pinHashKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
