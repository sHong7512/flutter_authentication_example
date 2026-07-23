// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure()';
}


}

/// @nodoc
class $AuthFailureCopyWith<$Res>  {
$AuthFailureCopyWith(AuthFailure _, $Res Function(AuthFailure) __);
}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotEnrolled value)?  notEnrolled,TResult Function( LockedOut value)?  lockedOut,TResult Function( PermanentlyLockedOut value)?  permanentlyLockedOut,TResult Function( PinMismatch value)?  pinMismatch,TResult Function( SystemError value)?  systemError,TResult Function( CanceledByUser value)?  canceledByUser,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotEnrolled() when notEnrolled != null:
return notEnrolled(_that);case LockedOut() when lockedOut != null:
return lockedOut(_that);case PermanentlyLockedOut() when permanentlyLockedOut != null:
return permanentlyLockedOut(_that);case PinMismatch() when pinMismatch != null:
return pinMismatch(_that);case SystemError() when systemError != null:
return systemError(_that);case CanceledByUser() when canceledByUser != null:
return canceledByUser(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotEnrolled value)  notEnrolled,required TResult Function( LockedOut value)  lockedOut,required TResult Function( PermanentlyLockedOut value)  permanentlyLockedOut,required TResult Function( PinMismatch value)  pinMismatch,required TResult Function( SystemError value)  systemError,required TResult Function( CanceledByUser value)  canceledByUser,}){
final _that = this;
switch (_that) {
case NotEnrolled():
return notEnrolled(_that);case LockedOut():
return lockedOut(_that);case PermanentlyLockedOut():
return permanentlyLockedOut(_that);case PinMismatch():
return pinMismatch(_that);case SystemError():
return systemError(_that);case CanceledByUser():
return canceledByUser(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotEnrolled value)?  notEnrolled,TResult? Function( LockedOut value)?  lockedOut,TResult? Function( PermanentlyLockedOut value)?  permanentlyLockedOut,TResult? Function( PinMismatch value)?  pinMismatch,TResult? Function( SystemError value)?  systemError,TResult? Function( CanceledByUser value)?  canceledByUser,}){
final _that = this;
switch (_that) {
case NotEnrolled() when notEnrolled != null:
return notEnrolled(_that);case LockedOut() when lockedOut != null:
return lockedOut(_that);case PermanentlyLockedOut() when permanentlyLockedOut != null:
return permanentlyLockedOut(_that);case PinMismatch() when pinMismatch != null:
return pinMismatch(_that);case SystemError() when systemError != null:
return systemError(_that);case CanceledByUser() when canceledByUser != null:
return canceledByUser(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  notEnrolled,TResult Function()?  lockedOut,TResult Function()?  permanentlyLockedOut,TResult Function()?  pinMismatch,TResult Function( String? message)?  systemError,TResult Function()?  canceledByUser,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotEnrolled() when notEnrolled != null:
return notEnrolled();case LockedOut() when lockedOut != null:
return lockedOut();case PermanentlyLockedOut() when permanentlyLockedOut != null:
return permanentlyLockedOut();case PinMismatch() when pinMismatch != null:
return pinMismatch();case SystemError() when systemError != null:
return systemError(_that.message);case CanceledByUser() when canceledByUser != null:
return canceledByUser();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  notEnrolled,required TResult Function()  lockedOut,required TResult Function()  permanentlyLockedOut,required TResult Function()  pinMismatch,required TResult Function( String? message)  systemError,required TResult Function()  canceledByUser,}) {final _that = this;
switch (_that) {
case NotEnrolled():
return notEnrolled();case LockedOut():
return lockedOut();case PermanentlyLockedOut():
return permanentlyLockedOut();case PinMismatch():
return pinMismatch();case SystemError():
return systemError(_that.message);case CanceledByUser():
return canceledByUser();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  notEnrolled,TResult? Function()?  lockedOut,TResult? Function()?  permanentlyLockedOut,TResult? Function()?  pinMismatch,TResult? Function( String? message)?  systemError,TResult? Function()?  canceledByUser,}) {final _that = this;
switch (_that) {
case NotEnrolled() when notEnrolled != null:
return notEnrolled();case LockedOut() when lockedOut != null:
return lockedOut();case PermanentlyLockedOut() when permanentlyLockedOut != null:
return permanentlyLockedOut();case PinMismatch() when pinMismatch != null:
return pinMismatch();case SystemError() when systemError != null:
return systemError(_that.message);case CanceledByUser() when canceledByUser != null:
return canceledByUser();case _:
  return null;

}
}

}

/// @nodoc


class NotEnrolled implements AuthFailure {
  const NotEnrolled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotEnrolled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.notEnrolled()';
}


}




/// @nodoc


class LockedOut implements AuthFailure {
  const LockedOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.lockedOut()';
}


}




/// @nodoc


class PermanentlyLockedOut implements AuthFailure {
  const PermanentlyLockedOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermanentlyLockedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.permanentlyLockedOut()';
}


}




/// @nodoc


class PinMismatch implements AuthFailure {
  const PinMismatch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinMismatch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.pinMismatch()';
}


}




/// @nodoc


class SystemError implements AuthFailure {
  const SystemError([this.message]);
  

 final  String? message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemErrorCopyWith<SystemError> get copyWith => _$SystemErrorCopyWithImpl<SystemError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.systemError(message: $message)';
}


}

/// @nodoc
abstract mixin class $SystemErrorCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory $SystemErrorCopyWith(SystemError value, $Res Function(SystemError) _then) = _$SystemErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$SystemErrorCopyWithImpl<$Res>
    implements $SystemErrorCopyWith<$Res> {
  _$SystemErrorCopyWithImpl(this._self, this._then);

  final SystemError _self;
  final $Res Function(SystemError) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(SystemError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CanceledByUser implements AuthFailure {
  const CanceledByUser();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CanceledByUser);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.canceledByUser()';
}


}




// dart format on
