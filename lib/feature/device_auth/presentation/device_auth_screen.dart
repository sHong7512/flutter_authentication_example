import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/auth_failure.dart';
import 'device_auth_view_model.dart';

class DeviceAuthScreen extends ConsumerStatefulWidget {
  const DeviceAuthScreen({super.key});

  @override
  ConsumerState<DeviceAuthScreen> createState() => _DeviceAuthScreenState();
}

class _DeviceAuthScreenState extends ConsumerState<DeviceAuthScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(deviceAuthViewModelProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceAuthStatus = ref.watch(deviceAuthViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('디바이스 OS 인증 설정')),
      body: deviceAuthStatus.when(
        data: (capabilities) {
          if (!capabilities.isDeviceSupported) {
            return const Center(
              child: Text(
                '이 기기는 PIN, 패턴, 생체 인식 등\n어떠한 보안 기능도 지원하지 않습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }

          // 1. 등록된 생체 인식 종류를 세분화하여 파싱합니다.
          final biometrics = capabilities.availableBiometrics;
          final hasFingerprint = biometrics.contains(BiometricType.fingerprint);
          final hasFace = biometrics.contains(BiometricType.face);
          final hasIris = biometrics.contains(BiometricType.iris);
          final hasAndroidStrong = biometrics.contains(BiometricType.strong);
          final hasAndroidWeak = biometrics.contains(BiometricType.weak);
          final hasAnyAndroid = hasAndroidStrong || hasAndroidWeak;

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const Text(
                '현재 기기의 보안 인증 지원 및 등록 상태',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '* 미지원/미등록으로 나오는 경우, OS 설정에서 해당 생체 정보가 등록되어 있는지 확인하세요.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // [1단계] 기본 기기 잠금
              _buildSectionTitle('기본 기기 보안'),
              _buildStatusTile(
                icon: Icons.password,
                title: '기기 잠금 (PIN / 패턴 / 비밀번호)',
                isSupported: capabilities.isDeviceSupported,
              ),
              const Divider(height: 32),

              // [2단계] 하드웨어 센서 여부
              _buildSectionTitle('생체 인식 하드웨어 상태'),
              _buildStatusTile(
                icon: Icons.sensors,
                title: '생체 인식 센서 탑재 및 권한 허용',
                isSupported: capabilities.canCheckBiometrics,
              ),
              const Divider(height: 32),

              // [3단계] 등록된 생체 인식 상세 분류
              _buildSectionTitle('활성화(등록)된 생체 인식 종류'),

              // 안드로이드 11이상 기기는 통합 규격
              _buildStatusTile(
                icon: Icons.android,
                title: '안드로이드 통합 생체 인식 (Strong/Weak)',
                subtitle: '안드로이드 11 이상 전용 통합 규격',
                isSupported: hasAnyAndroid,
              ),

              _buildStatusTile(
                icon: Icons.fingerprint,
                title: '지문 인식 (Touch ID)',
                subtitle: 'iOS 전체 및 안드로이드 10 이하 지원',
                isSupported: hasFingerprint,
              ),

              _buildStatusTile(
                icon: Icons.face,
                title: '얼굴 인식 (Face ID)',
                subtitle: 'iOS 전용 지원',
                isSupported: hasFace,
              ),

              _buildStatusTile(
                icon: Icons.remove_red_eye,
                title: '홍채 인식 (Iris)',
                subtitle: '일부 특수 기기 제한적 지원',
                isSupported: hasIris,
              ),

              const SizedBox(height: 48),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.settings),
                label: const Text('설정 화면으로 이동', style: TextStyle(fontSize: 16)),
                onPressed: capabilities.isDeviceSupported
                    ? () => _openSecuritySettings()
                    : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.security),
                label: const Text(
                  '디바이스 인증 테스트 실행',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: capabilities.isDeviceSupported
                    ? () => _executeAuth(context, ref)
                    : null,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('오류 발생: $err')),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _openSecuritySettings() async {
    try {
      // Android는 보안 설정으로 직접 이동, iOS는 범용 설정으로 이동합니다.
      await AppSettings.openAppSettings(type: AppSettingsType.security);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('설정 화면을 열 수 없습니다. 직접 설정 앱으로 이동해주세요.')),
        );
      }
    }
  }

  Future<void> _executeAuth(BuildContext context, WidgetRef ref) async {
    final result = await ref
        .read(deviceAuthViewModelProvider.notifier)
        .authenticate();

    if (context.mounted) {
      result.fold(
        (failure) {
          final message = failure.maybeWhen(
            notEnrolled: () => '기기에 설정된 화면 잠금이나 생체 인식이 없습니다.',
            lockedOut: () => '시도 횟수 초과로 잠금 처리되었습니다. 잠시 후 시도하세요.',
            permanentlyLockedOut: () => '영구 잠금되었습니다. PIN/패턴으로 해제하세요.',
            systemError: (msg) => msg ?? '시스템 오류가 발생했습니다.',
            canceledByUser: () => '사용자가 인증을 취소했습니다.',
            orElse: () => '인증에 실패했습니다.',
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OS 인증이 성공적으로 완료되었습니다! 🚀'),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
    }
  }

  Widget _buildStatusTile({
    required IconData icon,
    required String title,
    required bool isSupported,
    String? subtitle,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isSupported ? Colors.green : Colors.grey.shade400,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSupported ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSupported
              ? Colors.green.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          isSupported ? '등록됨' : '미등록/미지원',
          style: TextStyle(
            color: isSupported ? Colors.green : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
