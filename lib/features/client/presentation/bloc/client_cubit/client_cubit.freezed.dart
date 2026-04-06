// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientState {

 List<ClientEntity> get suggestions; ClientEntity? get selectedClient; String get searchQuery; String? get nextPageUrl; bool get isLoading;
/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientStateCopyWith<ClientState> get copyWith => _$ClientStateCopyWithImpl<ClientState>(this as ClientState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientState&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.selectedClient, selectedClient) || other.selectedClient == selectedClient)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(suggestions),selectedClient,searchQuery,nextPageUrl,isLoading);

@override
String toString() {
  return 'ClientState(suggestions: $suggestions, selectedClient: $selectedClient, searchQuery: $searchQuery, nextPageUrl: $nextPageUrl, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $ClientStateCopyWith<$Res>  {
  factory $ClientStateCopyWith(ClientState value, $Res Function(ClientState) _then) = _$ClientStateCopyWithImpl;
@useResult
$Res call({
 List<ClientEntity> suggestions, ClientEntity? selectedClient, String searchQuery, String? nextPageUrl, bool isLoading
});


$ClientEntityCopyWith<$Res>? get selectedClient;

}
/// @nodoc
class _$ClientStateCopyWithImpl<$Res>
    implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._self, this._then);

  final ClientState _self;
  final $Res Function(ClientState) _then;

/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestions = null,Object? selectedClient = freezed,Object? searchQuery = null,Object? nextPageUrl = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ClientEntity>,selectedClient: freezed == selectedClient ? _self.selectedClient : selectedClient // ignore: cast_nullable_to_non_nullable
as ClientEntity?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientEntityCopyWith<$Res>? get selectedClient {
    if (_self.selectedClient == null) {
    return null;
  }

  return $ClientEntityCopyWith<$Res>(_self.selectedClient!, (value) {
    return _then(_self.copyWith(selectedClient: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClientState].
extension ClientStatePatterns on ClientState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientState value)  $default,){
final _that = this;
switch (_that) {
case _ClientState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientState value)?  $default,){
final _that = this;
switch (_that) {
case _ClientState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ClientEntity> suggestions,  ClientEntity? selectedClient,  String searchQuery,  String? nextPageUrl,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientState() when $default != null:
return $default(_that.suggestions,_that.selectedClient,_that.searchQuery,_that.nextPageUrl,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ClientEntity> suggestions,  ClientEntity? selectedClient,  String searchQuery,  String? nextPageUrl,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _ClientState():
return $default(_that.suggestions,_that.selectedClient,_that.searchQuery,_that.nextPageUrl,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ClientEntity> suggestions,  ClientEntity? selectedClient,  String searchQuery,  String? nextPageUrl,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _ClientState() when $default != null:
return $default(_that.suggestions,_that.selectedClient,_that.searchQuery,_that.nextPageUrl,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _ClientState implements ClientState {
  const _ClientState({required final  List<ClientEntity> suggestions, required this.selectedClient, required this.searchQuery, this.nextPageUrl, this.isLoading = false}): _suggestions = suggestions;
  

 final  List<ClientEntity> _suggestions;
@override List<ClientEntity> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override final  ClientEntity? selectedClient;
@override final  String searchQuery;
@override final  String? nextPageUrl;
@override@JsonKey() final  bool isLoading;

/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientStateCopyWith<_ClientState> get copyWith => __$ClientStateCopyWithImpl<_ClientState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientState&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.selectedClient, selectedClient) || other.selectedClient == selectedClient)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestions),selectedClient,searchQuery,nextPageUrl,isLoading);

@override
String toString() {
  return 'ClientState(suggestions: $suggestions, selectedClient: $selectedClient, searchQuery: $searchQuery, nextPageUrl: $nextPageUrl, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$ClientStateCopyWith<$Res> implements $ClientStateCopyWith<$Res> {
  factory _$ClientStateCopyWith(_ClientState value, $Res Function(_ClientState) _then) = __$ClientStateCopyWithImpl;
@override @useResult
$Res call({
 List<ClientEntity> suggestions, ClientEntity? selectedClient, String searchQuery, String? nextPageUrl, bool isLoading
});


@override $ClientEntityCopyWith<$Res>? get selectedClient;

}
/// @nodoc
class __$ClientStateCopyWithImpl<$Res>
    implements _$ClientStateCopyWith<$Res> {
  __$ClientStateCopyWithImpl(this._self, this._then);

  final _ClientState _self;
  final $Res Function(_ClientState) _then;

/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestions = null,Object? selectedClient = freezed,Object? searchQuery = null,Object? nextPageUrl = freezed,Object? isLoading = null,}) {
  return _then(_ClientState(
suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ClientEntity>,selectedClient: freezed == selectedClient ? _self.selectedClient : selectedClient // ignore: cast_nullable_to_non_nullable
as ClientEntity?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ClientState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientEntityCopyWith<$Res>? get selectedClient {
    if (_self.selectedClient == null) {
    return null;
  }

  return $ClientEntityCopyWith<$Res>(_self.selectedClient!, (value) {
    return _then(_self.copyWith(selectedClient: value));
  });
}
}

// dart format on
