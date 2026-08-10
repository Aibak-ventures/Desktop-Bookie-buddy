// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qz_printer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QzPrinterState {

 PrinterBridgeStatus get status; List<PrinterDeviceEntity> get printers; String? get selectedPrinterName; String? get errorMessage;/// The printer that was saved as default *before* this session's
/// selection changed anything — purely for the picker UI to label a
/// "(default)" tag; never mutated by [QzPrinterCubit.selectPrinter].
 String? get lastUsedPrinterName;
/// Create a copy of QzPrinterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QzPrinterStateCopyWith<QzPrinterState> get copyWith => _$QzPrinterStateCopyWithImpl<QzPrinterState>(this as QzPrinterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QzPrinterState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.printers, printers)&&(identical(other.selectedPrinterName, selectedPrinterName) || other.selectedPrinterName == selectedPrinterName)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastUsedPrinterName, lastUsedPrinterName) || other.lastUsedPrinterName == lastUsedPrinterName));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(printers),selectedPrinterName,errorMessage,lastUsedPrinterName);

@override
String toString() {
  return 'QzPrinterState(status: $status, printers: $printers, selectedPrinterName: $selectedPrinterName, errorMessage: $errorMessage, lastUsedPrinterName: $lastUsedPrinterName)';
}


}

/// @nodoc
abstract mixin class $QzPrinterStateCopyWith<$Res>  {
  factory $QzPrinterStateCopyWith(QzPrinterState value, $Res Function(QzPrinterState) _then) = _$QzPrinterStateCopyWithImpl;
@useResult
$Res call({
 PrinterBridgeStatus status, List<PrinterDeviceEntity> printers, String? selectedPrinterName, String? errorMessage, String? lastUsedPrinterName
});




}
/// @nodoc
class _$QzPrinterStateCopyWithImpl<$Res>
    implements $QzPrinterStateCopyWith<$Res> {
  _$QzPrinterStateCopyWithImpl(this._self, this._then);

  final QzPrinterState _self;
  final $Res Function(QzPrinterState) _then;

/// Create a copy of QzPrinterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? printers = null,Object? selectedPrinterName = freezed,Object? errorMessage = freezed,Object? lastUsedPrinterName = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PrinterBridgeStatus,printers: null == printers ? _self.printers : printers // ignore: cast_nullable_to_non_nullable
as List<PrinterDeviceEntity>,selectedPrinterName: freezed == selectedPrinterName ? _self.selectedPrinterName : selectedPrinterName // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastUsedPrinterName: freezed == lastUsedPrinterName ? _self.lastUsedPrinterName : lastUsedPrinterName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QzPrinterState].
extension QzPrinterStatePatterns on QzPrinterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QzPrinterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QzPrinterState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QzPrinterState value)  $default,){
final _that = this;
switch (_that) {
case _QzPrinterState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QzPrinterState value)?  $default,){
final _that = this;
switch (_that) {
case _QzPrinterState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PrinterBridgeStatus status,  List<PrinterDeviceEntity> printers,  String? selectedPrinterName,  String? errorMessage,  String? lastUsedPrinterName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QzPrinterState() when $default != null:
return $default(_that.status,_that.printers,_that.selectedPrinterName,_that.errorMessage,_that.lastUsedPrinterName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PrinterBridgeStatus status,  List<PrinterDeviceEntity> printers,  String? selectedPrinterName,  String? errorMessage,  String? lastUsedPrinterName)  $default,) {final _that = this;
switch (_that) {
case _QzPrinterState():
return $default(_that.status,_that.printers,_that.selectedPrinterName,_that.errorMessage,_that.lastUsedPrinterName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PrinterBridgeStatus status,  List<PrinterDeviceEntity> printers,  String? selectedPrinterName,  String? errorMessage,  String? lastUsedPrinterName)?  $default,) {final _that = this;
switch (_that) {
case _QzPrinterState() when $default != null:
return $default(_that.status,_that.printers,_that.selectedPrinterName,_that.errorMessage,_that.lastUsedPrinterName);case _:
  return null;

}
}

}

/// @nodoc


class _QzPrinterState implements QzPrinterState {
  const _QzPrinterState({this.status = PrinterBridgeStatus.unknown, final  List<PrinterDeviceEntity> printers = const [], this.selectedPrinterName, this.errorMessage, this.lastUsedPrinterName}): _printers = printers;
  

@override@JsonKey() final  PrinterBridgeStatus status;
 final  List<PrinterDeviceEntity> _printers;
@override@JsonKey() List<PrinterDeviceEntity> get printers {
  if (_printers is EqualUnmodifiableListView) return _printers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_printers);
}

@override final  String? selectedPrinterName;
@override final  String? errorMessage;
/// The printer that was saved as default *before* this session's
/// selection changed anything — purely for the picker UI to label a
/// "(default)" tag; never mutated by [QzPrinterCubit.selectPrinter].
@override final  String? lastUsedPrinterName;

/// Create a copy of QzPrinterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QzPrinterStateCopyWith<_QzPrinterState> get copyWith => __$QzPrinterStateCopyWithImpl<_QzPrinterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QzPrinterState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._printers, _printers)&&(identical(other.selectedPrinterName, selectedPrinterName) || other.selectedPrinterName == selectedPrinterName)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastUsedPrinterName, lastUsedPrinterName) || other.lastUsedPrinterName == lastUsedPrinterName));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_printers),selectedPrinterName,errorMessage,lastUsedPrinterName);

@override
String toString() {
  return 'QzPrinterState(status: $status, printers: $printers, selectedPrinterName: $selectedPrinterName, errorMessage: $errorMessage, lastUsedPrinterName: $lastUsedPrinterName)';
}


}

/// @nodoc
abstract mixin class _$QzPrinterStateCopyWith<$Res> implements $QzPrinterStateCopyWith<$Res> {
  factory _$QzPrinterStateCopyWith(_QzPrinterState value, $Res Function(_QzPrinterState) _then) = __$QzPrinterStateCopyWithImpl;
@override @useResult
$Res call({
 PrinterBridgeStatus status, List<PrinterDeviceEntity> printers, String? selectedPrinterName, String? errorMessage, String? lastUsedPrinterName
});




}
/// @nodoc
class __$QzPrinterStateCopyWithImpl<$Res>
    implements _$QzPrinterStateCopyWith<$Res> {
  __$QzPrinterStateCopyWithImpl(this._self, this._then);

  final _QzPrinterState _self;
  final $Res Function(_QzPrinterState) _then;

/// Create a copy of QzPrinterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? printers = null,Object? selectedPrinterName = freezed,Object? errorMessage = freezed,Object? lastUsedPrinterName = freezed,}) {
  return _then(_QzPrinterState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PrinterBridgeStatus,printers: null == printers ? _self._printers : printers // ignore: cast_nullable_to_non_nullable
as List<PrinterDeviceEntity>,selectedPrinterName: freezed == selectedPrinterName ? _self.selectedPrinterName : selectedPrinterName // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastUsedPrinterName: freezed == lastUsedPrinterName ? _self.lastUsedPrinterName : lastUsedPrinterName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
