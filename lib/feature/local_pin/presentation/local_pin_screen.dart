import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_pin_view_model.dart';
import 'pin_entry_screen.dart';

class LocalPinScreen extends ConsumerWidget {
  const LocalPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinStatusAsync = ref.watch(localPinViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('(앱 로컬) PIN 관리 설정')),
      body: pinStatusAsync.when(
        data: (hasPin) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StatusBadge(label: '로컬 PIN 상태', isActive: hasPin),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PinEntryScreen(
                      mode: hasPin ? PinMode.modify : PinMode.register,
                    ),
                  ),
                ),
                child: Text(hasPin ? 'PIN 번호 수정' : 'PIN 번호 초기 등록'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: hasPin
                    ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const PinEntryScreen(mode: PinMode.login),
                  ),
                )
                    : null,
                child: const Text('PIN 인증 테스트'),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasPin
                      ? Colors.red.shade50
                      : Colors.grey.shade200,
                  foregroundColor: hasPin ? Colors.red : Colors.grey,
                  elevation: 0,
                ),
                onPressed: hasPin
                    ? () async {
                  await ref
                      .read(localPinViewModelProvider.notifier)
                      .removePin();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PIN이 안전하게 삭제되었습니다.')),
                    );
                  }
                }
                    : null,
                child: const Text('PIN 데이터 삭제'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('상태를 불러오는 중 오류가 발생했습니다: $error')),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final bool isActive;

  const _StatusBadge({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? Colors.green : Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            isActive ? 'ON' : 'OFF',
            style: TextStyle(
              color: isActive ? Colors.green : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}