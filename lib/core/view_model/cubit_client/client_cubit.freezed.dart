// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClientState {
  List<ClientModel> get suggestions => throw _privateConstructorUsedError;
  ClientModel? get selectedClient => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  String? get nextPageUrl => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientStateCopyWith<ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientStateCopyWith<$Res> {
  factory $ClientStateCopyWith(
    ClientState value,
    $Res Function(ClientState) then,
  ) = _$ClientStateCopyWithImpl<$Res, ClientState>;
  @useResult
  $Res call({
    List<ClientModel> suggestions,
    ClientModel? selectedClient,
    String searchQuery,
    String? nextPageUrl,
    bool isLoading,
  });

  $ClientModelCopyWith<$Res>? get selectedClient;
}

/// @nodoc
class _$ClientStateCopyWithImpl<$Res, $Val extends ClientState>
    implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestions = null,
    Object? selectedClient = freezed,
    Object? searchQuery = null,
    Object? nextPageUrl = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            suggestions: null == suggestions
                ? _value.suggestions
                : suggestions // ignore: cast_nullable_to_non_nullable
                      as List<ClientModel>,
            selectedClient: freezed == selectedClient
                ? _value.selectedClient
                : selectedClient // ignore: cast_nullable_to_non_nullable
                      as ClientModel?,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            nextPageUrl: freezed == nextPageUrl
                ? _value.nextPageUrl
                : nextPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientModelCopyWith<$Res>? get selectedClient {
    if (_value.selectedClient == null) {
      return null;
    }

    return $ClientModelCopyWith<$Res>(_value.selectedClient!, (value) {
      return _then(_value.copyWith(selectedClient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientStateImplCopyWith<$Res>
    implements $ClientStateCopyWith<$Res> {
  factory _$$ClientStateImplCopyWith(
    _$ClientStateImpl value,
    $Res Function(_$ClientStateImpl) then,
  ) = __$$ClientStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ClientModel> suggestions,
    ClientModel? selectedClient,
    String searchQuery,
    String? nextPageUrl,
    bool isLoading,
  });

  @override
  $ClientModelCopyWith<$Res>? get selectedClient;
}

/// @nodoc
class __$$ClientStateImplCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res, _$ClientStateImpl>
    implements _$$ClientStateImplCopyWith<$Res> {
  __$$ClientStateImplCopyWithImpl(
    _$ClientStateImpl _value,
    $Res Function(_$ClientStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestions = null,
    Object? selectedClient = freezed,
    Object? searchQuery = null,
    Object? nextPageUrl = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _$ClientStateImpl(
        suggestions: null == suggestions
            ? _value._suggestions
            : suggestions // ignore: cast_nullable_to_non_nullable
                  as List<ClientModel>,
        selectedClient: freezed == selectedClient
            ? _value.selectedClient
            : selectedClient // ignore: cast_nullable_to_non_nullable
                  as ClientModel?,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        nextPageUrl: freezed == nextPageUrl
            ? _value.nextPageUrl
            : nextPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ClientStateImpl implements _ClientState {
  const _$ClientStateImpl({
    required final List<ClientModel> suggestions,
    required this.selectedClient,
    required this.searchQuery,
    this.nextPageUrl,
    this.isLoading = false,
  }) : _suggestions = suggestions;

  final List<ClientModel> _suggestions;
  @override
  List<ClientModel> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  final ClientModel? selectedClient;
  @override
  final String searchQuery;
  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ClientState(suggestions: $suggestions, selectedClient: $selectedClient, searchQuery: $searchQuery, nextPageUrl: $nextPageUrl, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientStateImpl &&
            const DeepCollectionEquality().equals(
              other._suggestions,
              _suggestions,
            ) &&
            (identical(other.selectedClient, selectedClient) ||
                other.selectedClient == selectedClient) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_suggestions),
    selectedClient,
    searchQuery,
    nextPageUrl,
    isLoading,
  );

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientStateImplCopyWith<_$ClientStateImpl> get copyWith =>
      __$$ClientStateImplCopyWithImpl<_$ClientStateImpl>(this, _$identity);
}

abstract class _ClientState implements ClientState {
  const factory _ClientState({
    required final List<ClientModel> suggestions,
    required final ClientModel? selectedClient,
    required final String searchQuery,
    final String? nextPageUrl,
    final bool isLoading,
  }) = _$ClientStateImpl;

  @override
  List<ClientModel> get suggestions;
  @override
  ClientModel? get selectedClient;
  @override
  String get searchQuery;
  @override
  String? get nextPageUrl;
  @override
  bool get isLoading;

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientStateImplCopyWith<_$ClientStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
