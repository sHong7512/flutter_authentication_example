import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/auth_failure.dart';
import 'local_pin_view_model.dart';

enum PinMode { register, login, modify }

class PinEntryScreen extends ConsumerStatefulWidget {
  final PinMode mode;
  final VoidCallback? onSuccess;

  const PinEntryScreen({
    super.key,
    required this.mode,
    this.onSuccess,
  });

  @override
  ConsumerState<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends ConsumerState<PinEntryScreen> {
  String _inputPin = '';
  bool _isAuthenticating = false; // UI 자체적으로 로딩 상태(터치 잠금용)를 관리합니다.
  static const int pinLength = 6;

  void _onKeyTap(String key) {
    if (_isAuthenticating || _inputPin.length >= pinLength) return;

    setState(() {
      _inputPin += key;
    });

    if (_inputPin.length == pinLength) {
      _handlePinSubmission();
    }
  }

  // 능동적인 API 호출 방식으로 변경된 핵심 로직
  Future<void> _handlePinSubmission() async {
    setState(() => _isAuthenticating = true);

    final notifier = ref.read(localPinViewModelProvider.notifier);

    // API 결과를 담을 변수
    Either<AuthFailure, Unit>? result;

    switch (widget.mode) {
      case PinMode.register:
        result = await notifier.registerPin(_inputPin);
        break;
      case PinMode.modify:
        result = await notifier.modifyPin(_inputPin);
        break;
      case PinMode.login:
        result = await notifier.loginWithPin(_inputPin);
        break;
    }

    if (!mounted) return;

    // API 호출 결과를 즉시 분석하여 UI에 피드백을 제공합니다.
    result?.fold(
          (failure) {
        setState(() {
          _inputPin = '';
          _isAuthenticating = false;
        });

        if (failure is PinMismatch) {
          _showSnackBar('PIN 번호가 일치하지 않습니다.');
        } else if (failure is LockedOut) {
          _showSnackBar('입력 횟수 초과로 잠시 후 다시 시도해주세요.');
        } else {
          _showSnackBar('인증 중 오류가 발생했습니다.');
        }
      },
          (_) {
        String message = '인증 성공!';
        if (widget.mode == PinMode.register) message = 'PIN이 등록되었습니다!';
        if (widget.mode == PinMode.modify) message = 'PIN이 수정되었습니다!';

        _showSnackBar(message);
        widget.onSuccess?.call();
        Navigator.of(context).pop();
      },
    );
  }

  void _onBackspace() {
    if (_isAuthenticating) return;

    if (_inputPin.isNotEmpty) {
      setState(() {
        _inputPin = _inputPin.substring(0, _inputPin.length - 1);
      });
    }
  }

  String _getTitle() {
    switch (widget.mode) {
      case PinMode.register: return '(앱 로컬) PIN 등록';
      case PinMode.login: return '(앱 로컬) PIN 인증';
      case PinMode.modify: return '(앱 로컬) PIN 수정';
    }
  }

  String _getInstruction() {
    switch (widget.mode) {
      case PinMode.register: return '새로운 (앱 로컬) PIN 번호를 입력하세요';
      case PinMode.login: return '(앱 로컬) PIN 번호를 입력하세요';
      case PinMode.modify: return '새로 변경할 (앱 로컬) PIN 번호를 입력하세요';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_getTitle()), centerTitle: true),
      body: Column(
        children: [
          const Spacer(),
          Text(
            _getInstruction(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pinLength,
                  (index) => Container(
                margin: const EdgeInsets.all(8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < _inputPin.length ? Colors.blue : Colors.grey[300],
                  border: Border.all(
                    color: index < _inputPin.length ? Colors.blue : Colors.grey[400]!,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          _buildKeypad(),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Widget _buildKeypad() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      foregroundDecoration: _isAuthenticating
          ? const BoxDecoration(color: Colors.white54)
          : null,
      child: Column(
        children: [
          for (var i = 0; i < 3; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var j = 1; j <= 3; j++)
                  _KeyButton(
                    text: '${(i * 3) + j}',
                    onTap: () => _onKeyTap('${(i * 3) + j}'),
                  ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 80, height: 80),
              _KeyButton(text: '0', onTap: () => _onKeyTap('0')),
              _KeyButton(
                icon: Icons.backspace_outlined,
                onTap: _onBackspace,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;

  const _KeyButton({this.text, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => onTap(),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, size: 28, color: Colors.black87)
            : Text(
          text!,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}