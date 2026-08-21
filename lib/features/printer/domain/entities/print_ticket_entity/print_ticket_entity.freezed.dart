// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'print_ticket_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrintTicketEntity {

 List<PrintTicketCommand> get commands; PrinterPaperSize get paperSize;
/// Create a copy of PrintTicketEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrintTicketEntityCopyWith<PrintTicketEntity> get copyWith => _$PrintTicketEntityCopyWithImpl<PrintTicketEntity>(this as PrintTicketEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrintTicketEntity&&const DeepCollectionEquality().equals(other.commands, commands)&&(identical(other.paperSize, paperSize) || other.paperSize == paperSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(commands),paperSize);

@override
String toString() {
  return 'PrintTicketEntity(commands: $commands, paperSize: $paperSize)';
}


}

/// @nodoc
abstract mixin class $PrintTicketEntityCopyWith<$Res>  {
  factory $PrintTicketEntityCopyWith(PrintTicketEntity value, $Res Function(PrintTicketEntity) _then) = _$PrintTicketEntityCopyWithImpl;
@useResult
$Res call({
 List<PrintTicketCommand> commands, PrinterPaperSize paperSize
});




}
/// @nodoc
class _$PrintTicketEntityCopyWithImpl<$Res>
    implements $PrintTicketEntityCopyWith<$Res> {
  _$PrintTicketEntityCopyWithImpl(this._self, this._then);

  final PrintTicketEntity _self;
  final $Res Function(PrintTicketEntity) _then;

/// Create a copy of PrintTicketEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commands = null,Object? paperSize = null,}) {
  return _then(_self.copyWith(
commands: null == commands ? _self.commands : commands // ignore: cast_nullable_to_non_nullable
as List<PrintTicketCommand>,paperSize: null == paperSize ? _self.paperSize : paperSize // ignore: cast_nullable_to_non_nullable
as PrinterPaperSize,
  ));
}

}


/// Adds pattern-matching-related methods to [PrintTicketEntity].
extension PrintTicketEntityPatterns on PrintTicketEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrintTicketEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrintTicketEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrintTicketEntity value)  $default,){
final _that = this;
switch (_that) {
case _PrintTicketEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrintTicketEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PrintTicketEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PrintTicketCommand> commands,  PrinterPaperSize paperSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrintTicketEntity() when $default != null:
return $default(_that.commands,_that.paperSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PrintTicketCommand> commands,  PrinterPaperSize paperSize)  $default,) {final _that = this;
switch (_that) {
case _PrintTicketEntity():
return $default(_that.commands,_that.paperSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PrintTicketCommand> commands,  PrinterPaperSize paperSize)?  $default,) {final _that = this;
switch (_that) {
case _PrintTicketEntity() when $default != null:
return $default(_that.commands,_that.paperSize);case _:
  return null;

}
}

}

/// @nodoc


class _PrintTicketEntity implements PrintTicketEntity {
  const _PrintTicketEntity({required final  List<PrintTicketCommand> commands, this.paperSize = PrinterPaperSize.mm80}): _commands = commands;
  

 final  List<PrintTicketCommand> _commands;
@override List<PrintTicketCommand> get commands {
  if (_commands is EqualUnmodifiableListView) return _commands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_commands);
}

@override@JsonKey() final  PrinterPaperSize paperSize;

/// Create a copy of PrintTicketEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrintTicketEntityCopyWith<_PrintTicketEntity> get copyWith => __$PrintTicketEntityCopyWithImpl<_PrintTicketEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrintTicketEntity&&const DeepCollectionEquality().equals(other._commands, _commands)&&(identical(other.paperSize, paperSize) || other.paperSize == paperSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_commands),paperSize);

@override
String toString() {
  return 'PrintTicketEntity(commands: $commands, paperSize: $paperSize)';
}


}

/// @nodoc
abstract mixin class _$PrintTicketEntityCopyWith<$Res> implements $PrintTicketEntityCopyWith<$Res> {
  factory _$PrintTicketEntityCopyWith(_PrintTicketEntity value, $Res Function(_PrintTicketEntity) _then) = __$PrintTicketEntityCopyWithImpl;
@override @useResult
$Res call({
 List<PrintTicketCommand> commands, PrinterPaperSize paperSize
});




}
/// @nodoc
class __$PrintTicketEntityCopyWithImpl<$Res>
    implements _$PrintTicketEntityCopyWith<$Res> {
  __$PrintTicketEntityCopyWithImpl(this._self, this._then);

  final _PrintTicketEntity _self;
  final $Res Function(_PrintTicketEntity) _then;

/// Create a copy of PrintTicketEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commands = null,Object? paperSize = null,}) {
  return _then(_PrintTicketEntity(
commands: null == commands ? _self._commands : commands // ignore: cast_nullable_to_non_nullable
as List<PrintTicketCommand>,paperSize: null == paperSize ? _self.paperSize : paperSize // ignore: cast_nullable_to_non_nullable
as PrinterPaperSize,
  ));
}


}

// dart format on
