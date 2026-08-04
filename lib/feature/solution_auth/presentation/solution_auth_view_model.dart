import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'solution_auth_view_model.g.dart';

@riverpod
class SolutionAuthViewModel extends _$SolutionAuthViewModel {
  // 실패 시 재요청을 위해 마지막으로 발급받은 인증 ID를 저장[cite: 4]
  String? lastVerificationId;

  @override
  FutureOr<String?> build() {
    return null;
  }

  void updateResult(String result) {
    state = AsyncData(result);
  }

  void reset() {
    lastVerificationId = null;
    state = const AsyncData(null);
  }

  // 저장된 ID를 사용해 API를 다시 요청하는 함수 (버튼 트리거용)
  Future<void> retryFetch() async {
    if (lastVerificationId == null) return;

    // UI에 로딩 상태(CircularProgressIndicator) 표시를 위해 상태 전환
    state = const AsyncLoading();

    final resultText = await fetchVerificationData(lastVerificationId!);
    updateResult('결과 : $lastVerificationId\n api 요청 후 해석 데이터\n-> $resultText');
  }

  // 백엔드 없이 직접 포트원 API에서 본인인증 데이터 가져오기 (R&D 전용)
  Future<String> fetchVerificationData(String identityVerificationId) async {
    lastVerificationId = identityVerificationId;

    try {
      final url = Uri.parse(
        'https://api.portone.io/identity-verifications/$identityVerificationId',
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'PortOne XXX',
          'Content-Type': 'application/json',
        },
      );

      print('\n================ [PortOne API Response Log] ================');
      print('sHong] 1. Request URL :: $url');
      print('sHong] 2. Status Code :: ${response.statusCode}');
      print('sHong] 3. Headers :: ${response.headers}');
      try {
        final decodedBody = utf8.decode(response.bodyBytes);
        log('4. Body (UTF-8) :: $decodedBody', name: 'sHong');
      } catch (decodeError) {
        log('sHong] 4. Body (Raw) :: ${response.body}', name: 'sHong');
      }
      print('============================================================\n');

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final customer = data['verifiedCustomer'];

        if (customer != null) {
          final name = customer['name'] ?? '알 수 없음';
          final phone = customer['phoneNumber'] ?? '알 수 없음';
          final gender = customer['gender'] ?? '알 수 없음';
          final birth = customer['birthDate'] ?? '알 수 없음';

          return '🎉 본인인증 정보 조회 완료 🎉\n\n'
              '🧑 이름 : $name\n'
              '📱 번호 : $phone\n'
              '🎂 생년월일 : $birth\n'
              '🚻 성별 : $gender';
        } else {
          return '⚠️ 인증은 성공했으나 응답에 고객 정보가 없습니다.\n상태: ${data['status']}';
        }
      } else {
        return '❌ 정보 조회 실패\n코드: ${response.statusCode}\n사유: ${response.body}';
      }
    } catch (e, stack) {
      print('sHong] 통신 예외 발생 :: $e');
      print('sHong] StackTrace :: $stack');
      return '통신 중 오류 발생: $e';
    }
  }
}
