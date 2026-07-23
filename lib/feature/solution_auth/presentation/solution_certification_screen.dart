import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portone_flutter/v2/model/request/identity_verification_request.dart';
import 'package:portone_flutter/v2/model/response/identity_verification_response.dart';
import 'package:portone_flutter/v2/portone_identity_verification.dart';

class SolutionCertificationScreen extends StatelessWidget {
  const SolutionCertificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String identityVerificationId =
        'verify_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';

    return PortoneIdentityVerification(
      appBar: AppBar(
        title: const Text('솔루션 본인인증'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      initialChild: const Center(child: CircularProgressIndicator()),
      data: IdentityVerificationRequest(
        storeId: 'storeId',
        channelKey: 'channelKey',
        identityVerificationId: identityVerificationId,
      ),
      callback: (IdentityVerificationResponse response) {
        if (response.code != null ||
            response.message != null ||
            response.pgCode != null ||
            response.pgMessage != null) {
          print('sHong] response code:: ${response.code}');
          print('sHong] response message:: ${response.message}');
          print('sHong] response pgCode:: ${response.pgCode}');
          print('sHong] response pgMessage:: ${response.pgMessage}');
          Navigator.pop(context, {'success': false, 'message': '인증에 실패했습니다.'});
        } else {
          Navigator.pop(context, {
            'success': true,
            'identityVerificationId': response.identityVerificationId,
          });
        }
      },
    );
  }
}
