// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClientListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) loadClients,
    required TResult Function() loadNextPageClients,
    required TResult Function(ClientModel client) deleteClient,
    required TResult Function(ClientRequestModel client) editClient,
    required TResult Function(ClientRequestModel client) addClient,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? loadClients,
    TResult? Function()? loadNextPageClients,
    TResult? Function(ClientModel client)? deleteClient,
    TResult? Function(ClientRequestModel client)? editClient,
    TResult? Function(ClientRequestModel client)? addClient,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? loadClients,
    TResult Function()? loadNextPageClients,
    TResult Function(ClientModel client)? deleteClient,
    TResult Function(ClientRequestModel client)? editClient,
    TResult Function(ClientRequestModel client)? addClient,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_LoadNextPageClients value) loadNextPageClients,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_EditClient value) editClient,
    required TResult Function(_AddClient value) addClient,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_EditClient value)? editClient,
    TResult? Function(_AddClient value)? addClient,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_EditClient value)? editClient,
    TResult Function(_AddClient value)? addClient,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientListEventCopyWith<$Res> {
  factory $ClientListEventCopyWith(
    ClientListEvent value,
    $Res Function(ClientListEvent) then,
  ) = _$ClientListEventCopyWithImpl<$Res, ClientListEvent>;
}

/// @nodoc
class _$ClientListEventCopyWithImpl<$Res, $Val extends ClientListEvent>
    implements $ClientListEventCopyWith<$Res> {
  _$ClientListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadClientsImplCopyWith<$Res> {
  factory _$$LoadClientsImplCopyWith(
    _$LoadClientsImpl value,
    $Res Function(_$LoadClientsImpl) then,
  ) = __$$LoadClientsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? searchQuery});
}

/// @nodoc
class __$$LoadClientsImplCopyWithImpl<$Res>
    extends _$ClientListEventCopyWithImpl<$Res, _$LoadClientsImpl>
    implements _$$LoadClientsImplCopyWith<$Res> {
  __$$LoadClientsImplCopyWithImpl(
    _$LoadClientsImpl _value,
    $Res Function(_$LoadClientsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? searchQuery = freezed}) {
    return _then(
      _$LoadClientsImpl(
        searchQuery: freezed == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoadClientsImpl implements _LoadClients {
  const _$LoadClientsImpl({this.searchQuery});

  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'ClientListEvent.loadClients(searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadClientsImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchQuery);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadClientsImplCopyWith<_$LoadClientsImpl> get copyWith =>
      __$$LoadClientsImplCopyWithImpl<_$LoadClientsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) loadClients,
    required TResult Function() loadNextPageClients,
    required TResult Function(ClientModel client) deleteClient,
    required TResult Function(ClientRequestModel client) editClient,
    required TResult Function(ClientRequestModel client) addClient,
  }) {
    return loadClients(searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? loadClients,
    TResult? Function()? loadNextPageClients,
    TResult? Function(ClientModel client)? deleteClient,
    TResult? Function(ClientRequestModel client)? editClient,
    TResult? Function(ClientRequestModel client)? addClient,
  }) {
    return loadClients?.call(searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? loadClients,
    TResult Function()? loadNextPageClients,
    TResult Function(ClientModel client)? deleteClient,
    TResult Function(ClientRequestModel client)? editClient,
    TResult Function(ClientRequestModel client)? addClient,
    required TResult orElse(),
  }) {
    if (loadClients != null) {
      return loadClients(searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_LoadNextPageClients value) loadNextPageClients,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_EditClient value) editClient,
    required TResult Function(_AddClient value) addClient,
  }) {
    return loadClients(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_EditClient value)? editClient,
    TResult? Function(_AddClient value)? addClient,
  }) {
    return loadClients?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_EditClient value)? editClient,
    TResult Function(_AddClient value)? addClient,
    required TResult orElse(),
  }) {
    if (loadClients != null) {
      return loadClients(this);
    }
    return orElse();
  }
}

abstract class _LoadClients implements ClientListEvent {
  const factory _LoadClients({final String? searchQuery}) = _$LoadClientsImpl;

  String? get searchQuery;

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadClientsImplCopyWith<_$LoadClientsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageClientsImplCopyWith<$Res> {
  factory _$$LoadNextPageClientsImplCopyWith(
    _$LoadNextPageClientsImpl value,
    $Res Function(_$LoadNextPageClientsImpl) then,
  ) = __$$LoadNextPageClientsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageClientsImplCopyWithImpl<$Res>
    extends _$ClientListEventCopyWithImpl<$Res, _$LoadNextPageClientsImpl>
    implements _$$LoadNextPageClientsImplCopyWith<$Res> {
  __$$LoadNextPageClientsImplCopyWithImpl(
    _$LoadNextPageClientsImpl _value,
    $Res Function(_$LoadNextPageClientsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageClientsImpl implements _LoadNextPageClients {
  const _$LoadNextPageClientsImpl();

  @override
  String toString() {
    return 'ClientListEvent.loadNextPageClients()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageClientsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) loadClients,
    required TResult Function() loadNextPageClients,
    required TResult Function(ClientModel client) deleteClient,
    required TResult Function(ClientRequestModel client) editClient,
    required TResult Function(ClientRequestModel client) addClient,
  }) {
    return loadNextPageClients();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? loadClients,
    TResult? Function()? loadNextPageClients,
    TResult? Function(ClientModel client)? deleteClient,
    TResult? Function(ClientRequestModel client)? editClient,
    TResult? Function(ClientRequestModel client)? addClient,
  }) {
    return loadNextPageClients?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? loadClients,
    TResult Function()? loadNextPageClients,
    TResult Function(ClientModel client)? deleteClient,
    TResult Function(ClientRequestModel client)? editClient,
    TResult Function(ClientRequestModel client)? addClient,
    required TResult orElse(),
  }) {
    if (loadNextPageClients != null) {
      return loadNextPageClients();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_LoadNextPageClients value) loadNextPageClients,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_EditClient value) editClient,
    required TResult Function(_AddClient value) addClient,
  }) {
    return loadNextPageClients(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_EditClient value)? editClient,
    TResult? Function(_AddClient value)? addClient,
  }) {
    return loadNextPageClients?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_EditClient value)? editClient,
    TResult Function(_AddClient value)? addClient,
    required TResult orElse(),
  }) {
    if (loadNextPageClients != null) {
      return loadNextPageClients(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageClients implements ClientListEvent {
  const factory _LoadNextPageClients() = _$LoadNextPageClientsImpl;
}

/// @nodoc
abstract class _$$DeleteClientImplCopyWith<$Res> {
  factory _$$DeleteClientImplCopyWith(
    _$DeleteClientImpl value,
    $Res Function(_$DeleteClientImpl) then,
  ) = __$$DeleteClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClientModel client});

  $ClientModelCopyWith<$Res> get client;
}

/// @nodoc
class __$$DeleteClientImplCopyWithImpl<$Res>
    extends _$ClientListEventCopyWithImpl<$Res, _$DeleteClientImpl>
    implements _$$DeleteClientImplCopyWith<$Res> {
  __$$DeleteClientImplCopyWithImpl(
    _$DeleteClientImpl _value,
    $Res Function(_$DeleteClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? client = null}) {
    return _then(
      _$DeleteClientImpl(
        null == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as ClientModel,
      ),
    );
  }

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientModelCopyWith<$Res> get client {
    return $ClientModelCopyWith<$Res>(_value.client, (value) {
      return _then(_value.copyWith(client: value));
    });
  }
}

/// @nodoc

class _$DeleteClientImpl implements _DeleteClient {
  const _$DeleteClientImpl(this.client);

  @override
  final ClientModel client;

  @override
  String toString() {
    return 'ClientListEvent.deleteClient(client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteClientImpl &&
            (identical(other.client, client) || other.client == client));
  }

  @override
  int get hashCode => Object.hash(runtimeType, client);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteClientImplCopyWith<_$DeleteClientImpl> get copyWith =>
      __$$DeleteClientImplCopyWithImpl<_$DeleteClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) loadClients,
    required TResult Function() loadNextPageClients,
    required TResult Function(ClientModel client) deleteClient,
    required TResult Function(ClientRequestModel client) editClient,
    required TResult Function(ClientRequestModel client) addClient,
  }) {
    return deleteClient(client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? loadClients,
    TResult? Function()? loadNextPageClients,
    TResult? Function(ClientModel client)? deleteClient,
    TResult? Function(ClientRequestModel client)? editClient,
    TResult? Function(ClientRequestModel client)? addClient,
  }) {
    return deleteClient?.call(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? loadClients,
    TResult Function()? loadNextPageClients,
    TResult Function(ClientModel client)? deleteClient,
    TResult Function(ClientRequestModel client)? editClient,
    TResult Function(ClientRequestModel client)? addClient,
    required TResult orElse(),
  }) {
    if (deleteClient != null) {
      return deleteClient(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_LoadNextPageClients value) loadNextPageClients,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_EditClient value) editClient,
    required TResult Function(_AddClient value) addClient,
  }) {
    return deleteClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_EditClient value)? editClient,
    TResult? Function(_AddClient value)? addClient,
  }) {
    return deleteClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_EditClient value)? editClient,
    TResult Function(_AddClient value)? addClient,
    required TResult orElse(),
  }) {
    if (deleteClient != null) {
      return deleteClient(this);
    }
    return orElse();
  }
}

abstract class _DeleteClient implements ClientListEvent {
  const factory _DeleteClient(final ClientModel client) = _$DeleteClientImpl;

  ClientModel get client;

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteClientImplCopyWith<_$DeleteClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditClientImplCopyWith<$Res> {
  factory _$$EditClientImplCopyWith(
    _$EditClientImpl value,
    $Res Function(_$EditClientImpl) then,
  ) = __$$EditClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClientRequestModel client});

  $ClientRequestModelCopyWith<$Res> get client;
}

/// @nodoc
class __$$EditClientImplCopyWithImpl<$Res>
    extends _$ClientListEventCopyWithImpl<$Res, _$EditClientImpl>
    implements _$$EditClientImplCopyWith<$Res> {
  __$$EditClientImplCopyWithImpl(
    _$EditClientImpl _value,
    $Res Function(_$EditClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? client = null}) {
    return _then(
      _$EditClientImpl(
        null == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as ClientRequestModel,
      ),
    );
  }

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientRequestModelCopyWith<$Res> get client {
    return $ClientRequestModelCopyWith<$Res>(_value.client, (value) {
      return _then(_value.copyWith(client: value));
    });
  }
}

/// @nodoc

class _$EditClientImpl implements _EditClient {
  const _$EditClientImpl(this.client);

  @override
  final ClientRequestModel client;

  @override
  String toString() {
    return 'ClientListEvent.editClient(client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditClientImpl &&
            (identical(other.client, client) || other.client == client));
  }

  @override
  int get hashCode => Object.hash(runtimeType, client);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditClientImplCopyWith<_$EditClientImpl> get copyWith =>
      __$$EditClientImplCopyWithImpl<_$EditClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) loadClients,
    required TResult Function() loadNextPageClients,
    required TResult Function(ClientModel client) deleteClient,
    required TResult Function(ClientRequestModel client) editClient,
    required TResult Function(ClientRequestModel client) addClient,
  }) {
    return editClient(client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? loadClients,
    TResult? Function()? loadNextPageClients,
    TResult? Function(ClientModel client)? deleteClient,
    TResult? Function(ClientRequestModel client)? editClient,
    TResult? Function(ClientRequestModel client)? addClient,
  }) {
    return editClient?.call(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? loadClients,
    TResult Function()? loadNextPageClients,
    TResult Function(ClientModel client)? deleteClient,
    TResult Function(ClientRequestModel client)? editClient,
    TResult Function(ClientRequestModel client)? addClient,
    required TResult orElse(),
  }) {
    if (editClient != null) {
      return editClient(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_LoadNextPageClients value) loadNextPageClients,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_EditClient value) editClient,
    required TResult Function(_AddClient value) addClient,
  }) {
    return editClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_EditClient value)? editClient,
    TResult? Function(_AddClient value)? addClient,
  }) {
    return editClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_EditClient value)? editClient,
    TResult Function(_AddClient value)? addClient,
    required TResult orElse(),
  }) {
    if (editClient != null) {
      return editClient(this);
    }
    return orElse();
  }
}

abstract class _EditClient implements ClientListEvent {
  const factory _EditClient(final ClientRequestModel client) = _$EditClientImpl;

  ClientRequestModel get client;

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditClientImplCopyWith<_$EditClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClientImplCopyWith<$Res> {
  factory _$$AddClientImplCopyWith(
    _$AddClientImpl value,
    $Res Function(_$AddClientImpl) then,
  ) = __$$AddClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClientRequestModel client});

  $ClientRequestModelCopyWith<$Res> get client;
}

/// @nodoc
class __$$AddClientImplCopyWithImpl<$Res>
    extends _$ClientListEventCopyWithImpl<$Res, _$AddClientImpl>
    implements _$$AddClientImplCopyWith<$Res> {
  __$$AddClientImplCopyWithImpl(
    _$AddClientImpl _value,
    $Res Function(_$AddClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? client = null}) {
    return _then(
      _$AddClientImpl(
        null == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as ClientRequestModel,
      ),
    );
  }

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientRequestModelCopyWith<$Res> get client {
    return $ClientRequestModelCopyWith<$Res>(_value.client, (value) {
      return _then(_value.copyWith(client: value));
    });
  }
}

/// @nodoc

class _$AddClientImpl implements _AddClient {
  const _$AddClientImpl(this.client);

  @override
  final ClientRequestModel client;

  @override
  String toString() {
    return 'ClientListEvent.addClient(client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClientImpl &&
            (identical(other.client, client) || other.client == client));
  }

  @override
  int get hashCode => Object.hash(runtimeType, client);

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClientImplCopyWith<_$AddClientImpl> get copyWith =>
      __$$AddClientImplCopyWithImpl<_$AddClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? searchQuery) loadClients,
    required TResult Function() loadNextPageClients,
    required TResult Function(ClientModel client) deleteClient,
    required TResult Function(ClientRequestModel client) editClient,
    required TResult Function(ClientRequestModel client) addClient,
  }) {
    return addClient(client);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? searchQuery)? loadClients,
    TResult? Function()? loadNextPageClients,
    TResult? Function(ClientModel client)? deleteClient,
    TResult? Function(ClientRequestModel client)? editClient,
    TResult? Function(ClientRequestModel client)? addClient,
  }) {
    return addClient?.call(client);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? searchQuery)? loadClients,
    TResult Function()? loadNextPageClients,
    TResult Function(ClientModel client)? deleteClient,
    TResult Function(ClientRequestModel client)? editClient,
    TResult Function(ClientRequestModel client)? addClient,
    required TResult orElse(),
  }) {
    if (addClient != null) {
      return addClient(client);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClients value) loadClients,
    required TResult Function(_LoadNextPageClients value) loadNextPageClients,
    required TResult Function(_DeleteClient value) deleteClient,
    required TResult Function(_EditClient value) editClient,
    required TResult Function(_AddClient value) addClient,
  }) {
    return addClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClients value)? loadClients,
    TResult? Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult? Function(_DeleteClient value)? deleteClient,
    TResult? Function(_EditClient value)? editClient,
    TResult? Function(_AddClient value)? addClient,
  }) {
    return addClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClients value)? loadClients,
    TResult Function(_LoadNextPageClients value)? loadNextPageClients,
    TResult Function(_DeleteClient value)? deleteClient,
    TResult Function(_EditClient value)? editClient,
    TResult Function(_AddClient value)? addClient,
    required TResult orElse(),
  }) {
    if (addClient != null) {
      return addClient(this);
    }
    return orElse();
  }
}

abstract class _AddClient implements ClientListEvent {
  const factory _AddClient(final ClientRequestModel client) = _$AddClientImpl;

  ClientRequestModel get client;

  /// Create a copy of ClientListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddClientImplCopyWith<_$AddClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClientListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool didPop, bool needRefresh)
    success,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientListStateCopyWith<$Res> {
  factory $ClientListStateCopyWith(
    ClientListState value,
    $Res Function(ClientListState) then,
  ) = _$ClientListStateCopyWithImpl<$Res, ClientListState>;
}

/// @nodoc
class _$ClientListStateCopyWithImpl<$Res, $Val extends ClientListState>
    implements $ClientListStateCopyWith<$Res> {
  _$ClientListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ClientListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ClientListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool didPop, bool needRefresh)
    success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ClientListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<ClientModel> clients,
    String? nextPageUrl,
    bool isPaginating,
    bool isLoading,
    String? searchQuery,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ClientListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clients = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? isLoading = null,
    Object? searchQuery = freezed,
  }) {
    return _then(
      _$LoadedImpl(
        clients: null == clients
            ? _value._clients
            : clients // ignore: cast_nullable_to_non_nullable
                  as List<ClientModel>,
        nextPageUrl: freezed == nextPageUrl
            ? _value.nextPageUrl
            : nextPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPaginating: null == isPaginating
            ? _value.isPaginating
            : isPaginating // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchQuery: freezed == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<ClientModel> clients,
    required this.nextPageUrl,
    this.isPaginating = false,
    this.isLoading = false,
    this.searchQuery,
  }) : _clients = clients;

  final List<ClientModel> _clients;
  @override
  List<ClientModel> get clients {
    if (_clients is EqualUnmodifiableListView) return _clients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clients);
  }

  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'ClientListState.loaded(clients: $clients, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, isLoading: $isLoading, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_clients),
    nextPageUrl,
    isPaginating,
    isLoading,
    searchQuery,
  );

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool didPop, bool needRefresh)
    success,
  }) {
    return loaded(clients, nextPageUrl, isPaginating, isLoading, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return loaded?.call(
      clients,
      nextPageUrl,
      isPaginating,
      isLoading,
      searchQuery,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(clients, nextPageUrl, isPaginating, isLoading, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ClientListState {
  const factory _Loaded({
    required final List<ClientModel> clients,
    required final String? nextPageUrl,
    final bool isPaginating,
    final bool isLoading,
    final String? searchQuery,
  }) = _$LoadedImpl;

  List<ClientModel> get clients;
  String? get nextPageUrl;
  bool get isPaginating;
  bool get isLoading;
  String? get searchQuery;

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ClientListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$ErrorImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ClientListState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool didPop, bool needRefresh)
    success,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ClientListState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
    _$FailureImpl value,
    $Res Function(_$FailureImpl) then,
  ) = __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$ClientListStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
    _$FailureImpl _value,
    $Res Function(_$FailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ClientListState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool didPop, bool needRefresh)
    success,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements ClientListState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, bool didPop, bool needRefresh});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ClientListStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? didPop = null,
    Object? needRefresh = null,
  }) {
    return _then(
      _$SuccessImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        didPop: null == didPop
            ? _value.didPop
            : didPop // ignore: cast_nullable_to_non_nullable
                  as bool,
        needRefresh: null == needRefresh
            ? _value.needRefresh
            : needRefresh // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(
    this.message, {
    this.didPop = false,
    this.needRefresh = true,
  });

  @override
  final String message;
  @override
  @JsonKey()
  final bool didPop;
  @override
  @JsonKey()
  final bool needRefresh;

  @override
  String toString() {
    return 'ClientListState.success(message: $message, didPop: $didPop, needRefresh: $needRefresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.didPop, didPop) || other.didPop == didPop) &&
            (identical(other.needRefresh, needRefresh) ||
                other.needRefresh == needRefresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, didPop, needRefresh);

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool didPop, bool needRefresh)
    success,
  }) {
    return success(message, didPop, needRefresh);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return success?.call(message, didPop, needRefresh);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ClientModel> clients,
      String? nextPageUrl,
      bool isPaginating,
      bool isLoading,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, didPop, needRefresh);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ClientListState {
  const factory _Success(
    final String message, {
    final bool didPop,
    final bool needRefresh,
  }) = _$SuccessImpl;

  String get message;
  bool get didPop;
  bool get needRefresh;

  /// Create a copy of ClientListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
