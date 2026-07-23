import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'solution_auth_view_model.dart';
import 'solution_certification_screen.dart';

class SolutionAuthScreen extends ConsumerWidget {
  const SolutionAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(solutionAuthViewModelProvider);
    final hasLastId =
        ref.watch(solutionAuthViewModelProvider.notifier).lastVerificationId !=
        null;

    return Scaffold(
      appBar: AppBar(title: const Text('본인인증 대시보드'), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoCard(context),
              const SizedBox(height: 32),

              _buildResultCard(context, authState),

              const SizedBox(height: 24),

              // 저장된 ID가 있을 경우에만 동적으로 렌더링되는 재요청 버튼
              if (hasLastId) ...[
                OutlinedButton.icon(
                  onPressed: () {
                    ref.read(solutionAuthViewModelProvider.notifier).retryFetch();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('정보 조회 다시 요청하기(API요청)'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.indigo,
                    side: const BorderSide(color: Colors.indigo),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              ElevatedButton(
                onPressed: () => _startCertification(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '솔루션 본인인증 테스트 실행',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.withOpacity(0.2)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo),
              SizedBox(width: 8),
              Text(
                '안내',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'PortOne V2 SDK를 사용하여 솔루션 본인인증을 테스트합니다. 실제 환경에서는 발급받은 Store ID와 Channel Key가 필요합니다.',
            style: TextStyle(color: Colors.black87, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, AsyncValue<String?> authState) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '인증 결과',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            authState.when(
              data: (result) => Text(
                result ?? '인증 내역이 없습니다.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: result != null ? Colors.black : Colors.grey,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => Text(
                '오류: $err',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startCertification(BuildContext context, WidgetRef ref) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const SolutionCertificationScreen()),
    );

    if (result == null) return;

    final bool success = result['success'] ?? false;
    final String? message = result['message'];
    final String? id = result['identityVerificationId'];

    if (success && id != null) {
      ref
          .read(solutionAuthViewModelProvider.notifier)
          .updateResult('데이터를 가져오는 중입니다...');

      final resultText = await ref
          .read(solutionAuthViewModelProvider.notifier)
          .fetchVerificationData(id);

      ref
          .read(solutionAuthViewModelProvider.notifier)
          .updateResult('결과 : $id\n\n[ API 요청 후 해석 데이터 ]\n\n$resultText');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('본인인증에 성공하였습니다.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message ?? '본인인증에 실패하였습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
