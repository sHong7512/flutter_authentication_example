import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

typedef AuthCapabilities = ({
  bool isDeviceSupported, // PIN, 패턴, 비밀번호 등 기기 잠금 지원 여부
  bool canCheckBiometrics, // 생체 인식 하드웨어 탑재 및 권한 여부
  List<BiometricType> availableBiometrics, // 실제 등록된 생체 인식 목록 (지문, 얼굴 등)
});

class LocalAuthService {
  final LocalAuthentication _auth;

  LocalAuthService(this._auth);

  Future<AuthCapabilities> getCapabilities() async {
    final isDeviceSupported = await _auth.isDeviceSupported();
    final canCheckBiometrics = await _auth.canCheckBiometrics;

    List<BiometricType> availableBiometrics = [];

    // 생체 인식 검사가 가능한 경우에만 등록된 생체 인식 목록을 가져옵니다.
    if (canCheckBiometrics) {
      try {
        availableBiometrics = await _auth.getAvailableBiometrics();
      } catch (e) {
        // PlatformException 예외 처리 방어 로직
        availableBiometrics = [];
      }
    }

    return (
      isDeviceSupported: isDeviceSupported,
      canCheckBiometrics: canCheckBiometrics,
      availableBiometrics: availableBiometrics,
    );
  }

  Future<bool> authenticate() async {
    return await _auth.authenticate(
      localizedReason: '(예시) 생체 인증 이유 안내',
      authMessages: const <AuthMessages>[
        AndroidAuthMessages(signInTitle: '(예시) 디바이스 인증 타이틀'),
        IOSAuthMessages(cancelButton: '취소'),
      ],
    );
  }
}
