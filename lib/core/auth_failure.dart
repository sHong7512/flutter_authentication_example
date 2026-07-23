import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@Freezed(when: FreezedWhenOptions.all)
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.notEnrolled() = NotEnrolled;
  const factory AuthFailure.lockedOut() = LockedOut;
  const factory AuthFailure.permanentlyLockedOut() = PermanentlyLockedOut;
  const factory AuthFailure.pinMismatch() = PinMismatch;
  const factory AuthFailure.systemError([String? message]) = SystemError;
  const factory AuthFailure.canceledByUser() = CanceledByUser;
}
