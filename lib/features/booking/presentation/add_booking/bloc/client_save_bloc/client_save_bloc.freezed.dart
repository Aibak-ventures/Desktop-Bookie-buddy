// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

// part of 'client_save_bloc.dart';

// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************

// T _$identity<T>(T value) => value;

// final _privateConstructorUsedError = UnsupportedError(
//     'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

// /// @nodoc
// mixin _$ClientSaveEvent {
//   ClientRequestModel get client => throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function(ClientRequestModel client) saveClient,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function(ClientRequestModel client)? saveClient,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function(ClientRequestModel client)? saveClient,
//     required TResult orElse(),
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(_SaveClient value) saveClient,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(_SaveClient value)? saveClient,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(_SaveClient value)? saveClient,
//     required TResult orElse(),
//   }) =>
//       throw _privateConstructorUsedError;

//   /// Create a copy of ClientSaveEvent
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   $ClientSaveEventCopyWith<ClientSaveEvent> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class $ClientSaveEventCopyWith<$Res> {
//   factory $ClientSaveEventCopyWith(
//           ClientSaveEvent value, $Res Function(ClientSaveEvent) then) =
//       _$ClientSaveEventCopyWithImpl<$Res, ClientSaveEvent>;
//   @useResult
//   $Res call({ClientRequestModel client});

//   $ClientRequestModelCopyWith<$Res> get client;
// }

// /// @nodoc
// class _$ClientSaveEventCopyWithImpl<$Res, $Val extends ClientSaveEvent>
//     implements $ClientSaveEventCopyWith<$Res> {
//   _$ClientSaveEventCopyWithImpl(this._value, this._then);

//   // ignore: unused_field
//   final $Val _value;
//   // ignore: unused_field
//   final $Res Function($Val) _then;

//   /// Create a copy of ClientSaveEvent
//   /// with the given fields replaced by the non-null parameter values.
//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? client = null,
//   }) {
//     return _then(_value.copyWith(
//       client: null == client
//           ? _value.client
//           : client // ignore: cast_nullable_to_non_nullable
//               as ClientRequestModel,
//     ) as $Val);
//   }

//   /// Create a copy of ClientSaveEvent
//   /// with the given fields replaced by the non-null parameter values.
//   @override
//   @pragma('vm:prefer-inline')
//   $ClientRequestModelCopyWith<$Res> get client {
//     return $ClientRequestModelCopyWith<$Res>(_value.client, (value) {
//       return _then(_value.copyWith(client: value) as $Val);
//     });
//   }
// }

// /// @nodoc
// abstract class _$$SaveClientImplCopyWith<$Res>
//     implements $ClientSaveEventCopyWith<$Res> {
//   factory _$$SaveClientImplCopyWith(
//           _$SaveClientImpl value, $Res Function(_$SaveClientImpl) then) =
//       __$$SaveClientImplCopyWithImpl<$Res>;
//   @override
//   @useResult
//   $Res call({ClientRequestModel client});

//   @override
//   $ClientRequestModelCopyWith<$Res> get client;
// }

// /// @nodoc
// class __$$SaveClientImplCopyWithImpl<$Res>
//     extends _$ClientSaveEventCopyWithImpl<$Res, _$SaveClientImpl>
//     implements _$$SaveClientImplCopyWith<$Res> {
//   __$$SaveClientImplCopyWithImpl(
//       _$SaveClientImpl _value, $Res Function(_$SaveClientImpl) _then)
//       : super(_value, _then);

//   /// Create a copy of ClientSaveEvent
//   /// with the given fields replaced by the non-null parameter values.
//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? client = null,
//   }) {
//     return _then(_$SaveClientImpl(
//       null == client
//           ? _value.client
//           : client // ignore: cast_nullable_to_non_nullable
//               as ClientRequestModel,
//     ));
//   }
// }

// /// @nodoc

// class _$SaveClientImpl implements _SaveClient {
//   const _$SaveClientImpl(this.client);

//   @override
//   final ClientRequestModel client;

//   @override
//   String toString() {
//     return 'ClientSaveEvent.saveClient(client: $client)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$SaveClientImpl &&
//             (identical(other.client, client) || other.client == client));
//   }

//   @override
//   int get hashCode => Object.hash(runtimeType, client);

//   /// Create a copy of ClientSaveEvent
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$SaveClientImplCopyWith<_$SaveClientImpl> get copyWith =>
//       __$$SaveClientImplCopyWithImpl<_$SaveClientImpl>(this, _$identity);

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function(ClientRequestModel client) saveClient,
//   }) {
//     return saveClient(client);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function(ClientRequestModel client)? saveClient,
//   }) {
//     return saveClient?.call(client);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function(ClientRequestModel client)? saveClient,
//     required TResult orElse(),
//   }) {
//     if (saveClient != null) {
//       return saveClient(client);
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(_SaveClient value) saveClient,
//   }) {
//     return saveClient(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(_SaveClient value)? saveClient,
//   }) {
//     return saveClient?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(_SaveClient value)? saveClient,
//     required TResult orElse(),
//   }) {
//     if (saveClient != null) {
//       return saveClient(this);
//     }
//     return orElse();
//   }
// }

// abstract class _SaveClient implements ClientSaveEvent {
//   const factory _SaveClient(final ClientRequestModel client) = _$SaveClientImpl;

//   @override
//   ClientRequestModel get client;

//   /// Create a copy of ClientSaveEvent
//   /// with the given fields replaced by the non-null parameter values.
//   @override
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   _$$SaveClientImplCopyWith<_$SaveClientImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// mixin _$ClientSaveState {
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function() initial,
//     required TResult Function() saving,
//     required TResult Function(String message, ClientModel client) success,
//     required TResult Function(String message) failure,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function()? initial,
//     TResult? Function()? saving,
//     TResult? Function(String message, ClientModel client)? success,
//     TResult? Function(String message)? failure,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function()? initial,
//     TResult Function()? saving,
//     TResult Function(String message, ClientModel client)? success,
//     TResult Function(String message)? failure,
//     required TResult orElse(),
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(_Initial value) initial,
//     required TResult Function(_Saving value) saving,
//     required TResult Function(_Success value) success,
//     required TResult Function(_Failure value) failure,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(_Initial value)? initial,
//     TResult? Function(_Saving value)? saving,
//     TResult? Function(_Success value)? success,
//     TResult? Function(_Failure value)? failure,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(_Initial value)? initial,
//     TResult Function(_Saving value)? saving,
//     TResult Function(_Success value)? success,
//     TResult Function(_Failure value)? failure,
//     required TResult orElse(),
//   }) =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class $ClientSaveStateCopyWith<$Res> {
//   factory $ClientSaveStateCopyWith(
//           ClientSaveState value, $Res Function(ClientSaveState) then) =
//       _$ClientSaveStateCopyWithImpl<$Res, ClientSaveState>;
// }

// /// @nodoc
// class _$ClientSaveStateCopyWithImpl<$Res, $Val extends ClientSaveState>
//     implements $ClientSaveStateCopyWith<$Res> {
//   _$ClientSaveStateCopyWithImpl(this._value, this._then);

//   // ignore: unused_field
//   final $Val _value;
//   // ignore: unused_field
//   final $Res Function($Val) _then;

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
// }

// /// @nodoc
// abstract class _$$InitialImplCopyWith<$Res> {
//   factory _$$InitialImplCopyWith(
//           _$InitialImpl value, $Res Function(_$InitialImpl) then) =
//       __$$InitialImplCopyWithImpl<$Res>;
// }

// /// @nodoc
// class __$$InitialImplCopyWithImpl<$Res>
//     extends _$ClientSaveStateCopyWithImpl<$Res, _$InitialImpl>
//     implements _$$InitialImplCopyWith<$Res> {
//   __$$InitialImplCopyWithImpl(
//       _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
//       : super(_value, _then);

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
// }

// /// @nodoc

// class _$InitialImpl implements _Initial {
//   const _$InitialImpl();

//   @override
//   String toString() {
//     return 'ClientSaveState.initial()';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType && other is _$InitialImpl);
//   }

//   @override
//   int get hashCode => runtimeType.hashCode;

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function() initial,
//     required TResult Function() saving,
//     required TResult Function(String message, ClientModel client) success,
//     required TResult Function(String message) failure,
//   }) {
//     return initial();
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function()? initial,
//     TResult? Function()? saving,
//     TResult? Function(String message, ClientModel client)? success,
//     TResult? Function(String message)? failure,
//   }) {
//     return initial?.call();
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function()? initial,
//     TResult Function()? saving,
//     TResult Function(String message, ClientModel client)? success,
//     TResult Function(String message)? failure,
//     required TResult orElse(),
//   }) {
//     if (initial != null) {
//       return initial();
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(_Initial value) initial,
//     required TResult Function(_Saving value) saving,
//     required TResult Function(_Success value) success,
//     required TResult Function(_Failure value) failure,
//   }) {
//     return initial(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(_Initial value)? initial,
//     TResult? Function(_Saving value)? saving,
//     TResult? Function(_Success value)? success,
//     TResult? Function(_Failure value)? failure,
//   }) {
//     return initial?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(_Initial value)? initial,
//     TResult Function(_Saving value)? saving,
//     TResult Function(_Success value)? success,
//     TResult Function(_Failure value)? failure,
//     required TResult orElse(),
//   }) {
//     if (initial != null) {
//       return initial(this);
//     }
//     return orElse();
//   }
// }

// abstract class _Initial implements ClientSaveState {
//   const factory _Initial() = _$InitialImpl;
// }

// /// @nodoc
// abstract class _$$SavingImplCopyWith<$Res> {
//   factory _$$SavingImplCopyWith(
//           _$SavingImpl value, $Res Function(_$SavingImpl) then) =
//       __$$SavingImplCopyWithImpl<$Res>;
// }

// /// @nodoc
// class __$$SavingImplCopyWithImpl<$Res>
//     extends _$ClientSaveStateCopyWithImpl<$Res, _$SavingImpl>
//     implements _$$SavingImplCopyWith<$Res> {
//   __$$SavingImplCopyWithImpl(
//       _$SavingImpl _value, $Res Function(_$SavingImpl) _then)
//       : super(_value, _then);

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
// }

// /// @nodoc

// class _$SavingImpl implements _Saving {
//   const _$SavingImpl();

//   @override
//   String toString() {
//     return 'ClientSaveState.saving()';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType && other is _$SavingImpl);
//   }

//   @override
//   int get hashCode => runtimeType.hashCode;

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function() initial,
//     required TResult Function() saving,
//     required TResult Function(String message, ClientModel client) success,
//     required TResult Function(String message) failure,
//   }) {
//     return saving();
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function()? initial,
//     TResult? Function()? saving,
//     TResult? Function(String message, ClientModel client)? success,
//     TResult? Function(String message)? failure,
//   }) {
//     return saving?.call();
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function()? initial,
//     TResult Function()? saving,
//     TResult Function(String message, ClientModel client)? success,
//     TResult Function(String message)? failure,
//     required TResult orElse(),
//   }) {
//     if (saving != null) {
//       return saving();
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(_Initial value) initial,
//     required TResult Function(_Saving value) saving,
//     required TResult Function(_Success value) success,
//     required TResult Function(_Failure value) failure,
//   }) {
//     return saving(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(_Initial value)? initial,
//     TResult? Function(_Saving value)? saving,
//     TResult? Function(_Success value)? success,
//     TResult? Function(_Failure value)? failure,
//   }) {
//     return saving?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(_Initial value)? initial,
//     TResult Function(_Saving value)? saving,
//     TResult Function(_Success value)? success,
//     TResult Function(_Failure value)? failure,
//     required TResult orElse(),
//   }) {
//     if (saving != null) {
//       return saving(this);
//     }
//     return orElse();
//   }
// }

// abstract class _Saving implements ClientSaveState {
//   const factory _Saving() = _$SavingImpl;
// }

// /// @nodoc
// abstract class _$$SuccessImplCopyWith<$Res> {
//   factory _$$SuccessImplCopyWith(
//           _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
//       __$$SuccessImplCopyWithImpl<$Res>;
//   @useResult
//   $Res call({String message, ClientModel client});

//   $ClientModelCopyWith<$Res> get client;
// }

// /// @nodoc
// class __$$SuccessImplCopyWithImpl<$Res>
//     extends _$ClientSaveStateCopyWithImpl<$Res, _$SuccessImpl>
//     implements _$$SuccessImplCopyWith<$Res> {
//   __$$SuccessImplCopyWithImpl(
//       _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
//       : super(_value, _then);

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? message = null,
//     Object? client = null,
//   }) {
//     return _then(_$SuccessImpl(
//       null == message
//           ? _value.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//       null == client
//           ? _value.client
//           : client // ignore: cast_nullable_to_non_nullable
//               as ClientModel,
//     ));
//   }

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
//   @override
//   @pragma('vm:prefer-inline')
//   $ClientModelCopyWith<$Res> get client {
//     return $ClientModelCopyWith<$Res>(_value.client, (value) {
//       return _then(_value.copyWith(client: value));
//     });
//   }
// }

// /// @nodoc

// class _$SuccessImpl implements _Success {
//   const _$SuccessImpl(this.message, this.client);

//   @override
//   final String message;
//   @override
//   final ClientModel client;

//   @override
//   String toString() {
//     return 'ClientSaveState.success(message: $message, client: $client)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$SuccessImpl &&
//             (identical(other.message, message) || other.message == message) &&
//             (identical(other.client, client) || other.client == client));
//   }

//   @override
//   int get hashCode => Object.hash(runtimeType, message, client);

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
//       __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function() initial,
//     required TResult Function() saving,
//     required TResult Function(String message, ClientModel client) success,
//     required TResult Function(String message) failure,
//   }) {
//     return success(message, client);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function()? initial,
//     TResult? Function()? saving,
//     TResult? Function(String message, ClientModel client)? success,
//     TResult? Function(String message)? failure,
//   }) {
//     return success?.call(message, client);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function()? initial,
//     TResult Function()? saving,
//     TResult Function(String message, ClientModel client)? success,
//     TResult Function(String message)? failure,
//     required TResult orElse(),
//   }) {
//     if (success != null) {
//       return success(message, client);
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(_Initial value) initial,
//     required TResult Function(_Saving value) saving,
//     required TResult Function(_Success value) success,
//     required TResult Function(_Failure value) failure,
//   }) {
//     return success(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(_Initial value)? initial,
//     TResult? Function(_Saving value)? saving,
//     TResult? Function(_Success value)? success,
//     TResult? Function(_Failure value)? failure,
//   }) {
//     return success?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(_Initial value)? initial,
//     TResult Function(_Saving value)? saving,
//     TResult Function(_Success value)? success,
//     TResult Function(_Failure value)? failure,
//     required TResult orElse(),
//   }) {
//     if (success != null) {
//       return success(this);
//     }
//     return orElse();
//   }
// }

// abstract class _Success implements ClientSaveState {
//   const factory _Success(final String message, final ClientModel client) =
//       _$SuccessImpl;

//   String get message;
//   ClientModel get client;

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class _$$FailureImplCopyWith<$Res> {
//   factory _$$FailureImplCopyWith(
//           _$FailureImpl value, $Res Function(_$FailureImpl) then) =
//       __$$FailureImplCopyWithImpl<$Res>;
//   @useResult
//   $Res call({String message});
// }

// /// @nodoc
// class __$$FailureImplCopyWithImpl<$Res>
//     extends _$ClientSaveStateCopyWithImpl<$Res, _$FailureImpl>
//     implements _$$FailureImplCopyWith<$Res> {
//   __$$FailureImplCopyWithImpl(
//       _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
//       : super(_value, _then);

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? message = null,
//   }) {
//     return _then(_$FailureImpl(
//       null == message
//           ? _value.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//     ));
//   }
// }

// /// @nodoc

// class _$FailureImpl implements _Failure {
//   const _$FailureImpl(this.message);

//   @override
//   final String message;

//   @override
//   String toString() {
//     return 'ClientSaveState.failure(message: $message)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$FailureImpl &&
//             (identical(other.message, message) || other.message == message));
//   }

//   @override
//   int get hashCode => Object.hash(runtimeType, message);

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
//       __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function() initial,
//     required TResult Function() saving,
//     required TResult Function(String message, ClientModel client) success,
//     required TResult Function(String message) failure,
//   }) {
//     return failure(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function()? initial,
//     TResult? Function()? saving,
//     TResult? Function(String message, ClientModel client)? success,
//     TResult? Function(String message)? failure,
//   }) {
//     return failure?.call(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function()? initial,
//     TResult Function()? saving,
//     TResult Function(String message, ClientModel client)? success,
//     TResult Function(String message)? failure,
//     required TResult orElse(),
//   }) {
//     if (failure != null) {
//       return failure(message);
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(_Initial value) initial,
//     required TResult Function(_Saving value) saving,
//     required TResult Function(_Success value) success,
//     required TResult Function(_Failure value) failure,
//   }) {
//     return failure(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(_Initial value)? initial,
//     TResult? Function(_Saving value)? saving,
//     TResult? Function(_Success value)? success,
//     TResult? Function(_Failure value)? failure,
//   }) {
//     return failure?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(_Initial value)? initial,
//     TResult Function(_Saving value)? saving,
//     TResult Function(_Success value)? success,
//     TResult Function(_Failure value)? failure,
//     required TResult orElse(),
//   }) {
//     if (failure != null) {
//       return failure(this);
//     }
//     return orElse();
//   }
// }

// abstract class _Failure implements ClientSaveState {
//   const factory _Failure(final String message) = _$FailureImpl;

//   String get message;

//   /// Create a copy of ClientSaveState
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }
