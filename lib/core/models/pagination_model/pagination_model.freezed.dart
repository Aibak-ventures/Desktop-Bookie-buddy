// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PaginationModel<T> {
  List<T> get data => throw _privateConstructorUsedError;
  String? get nextPageUrl => throw _privateConstructorUsedError;
  String? get previousPageUrl => throw _privateConstructorUsedError;
  int get totalData => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get startIndex => throw _privateConstructorUsedError;
  int get endIndex => throw _privateConstructorUsedError;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationModelCopyWith<T, PaginationModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationModelCopyWith<T, $Res> {
  factory $PaginationModelCopyWith(
    PaginationModel<T> value,
    $Res Function(PaginationModel<T>) then,
  ) = _$PaginationModelCopyWithImpl<T, $Res, PaginationModel<T>>;
  @useResult
  $Res call({
    List<T> data,
    String? nextPageUrl,
    String? previousPageUrl,
    int totalData,
    int pageSize,
    int currentPage,
    int totalPages,
    int startIndex,
    int endIndex,
  });
}

/// @nodoc
class _$PaginationModelCopyWithImpl<T, $Res, $Val extends PaginationModel<T>>
    implements $PaginationModelCopyWith<T, $Res> {
  _$PaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? nextPageUrl = freezed,
    Object? previousPageUrl = freezed,
    Object? totalData = null,
    Object? pageSize = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? startIndex = null,
    Object? endIndex = null,
  }) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            nextPageUrl: freezed == nextPageUrl
                ? _value.nextPageUrl
                : nextPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            previousPageUrl: freezed == previousPageUrl
                ? _value.previousPageUrl
                : previousPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalData: null == totalData
                ? _value.totalData
                : totalData // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            startIndex: null == startIndex
                ? _value.startIndex
                : startIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            endIndex: null == endIndex
                ? _value.endIndex
                : endIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationModelImplCopyWith<T, $Res>
    implements $PaginationModelCopyWith<T, $Res> {
  factory _$$PaginationModelImplCopyWith(
    _$PaginationModelImpl<T> value,
    $Res Function(_$PaginationModelImpl<T>) then,
  ) = __$$PaginationModelImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    List<T> data,
    String? nextPageUrl,
    String? previousPageUrl,
    int totalData,
    int pageSize,
    int currentPage,
    int totalPages,
    int startIndex,
    int endIndex,
  });
}

/// @nodoc
class __$$PaginationModelImplCopyWithImpl<T, $Res>
    extends _$PaginationModelCopyWithImpl<T, $Res, _$PaginationModelImpl<T>>
    implements _$$PaginationModelImplCopyWith<T, $Res> {
  __$$PaginationModelImplCopyWithImpl(
    _$PaginationModelImpl<T> _value,
    $Res Function(_$PaginationModelImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? nextPageUrl = freezed,
    Object? previousPageUrl = freezed,
    Object? totalData = null,
    Object? pageSize = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? startIndex = null,
    Object? endIndex = null,
  }) {
    return _then(
      _$PaginationModelImpl<T>(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        nextPageUrl: freezed == nextPageUrl
            ? _value.nextPageUrl
            : nextPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        previousPageUrl: freezed == previousPageUrl
            ? _value.previousPageUrl
            : previousPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalData: null == totalData
            ? _value.totalData
            : totalData // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        startIndex: null == startIndex
            ? _value.startIndex
            : startIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        endIndex: null == endIndex
            ? _value.endIndex
            : endIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PaginationModelImpl<T> implements _PaginationModel<T> {
  const _$PaginationModelImpl({
    required final List<T> data,
    this.nextPageUrl,
    this.previousPageUrl,
    this.totalData = 0,
    this.pageSize = 0,
    this.currentPage = 1,
    this.totalPages = 0,
    this.startIndex = 0,
    this.endIndex = 0,
  }) : _data = data;

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String? nextPageUrl;
  @override
  final String? previousPageUrl;
  @override
  @JsonKey()
  final int totalData;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int startIndex;
  @override
  @JsonKey()
  final int endIndex;

  @override
  String toString() {
    return 'PaginationModel<$T>(data: $data, nextPageUrl: $nextPageUrl, previousPageUrl: $previousPageUrl, totalData: $totalData, pageSize: $pageSize, currentPage: $currentPage, totalPages: $totalPages, startIndex: $startIndex, endIndex: $endIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationModelImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.previousPageUrl, previousPageUrl) ||
                other.previousPageUrl == previousPageUrl) &&
            (identical(other.totalData, totalData) ||
                other.totalData == totalData) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            (identical(other.endIndex, endIndex) ||
                other.endIndex == endIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    nextPageUrl,
    previousPageUrl,
    totalData,
    pageSize,
    currentPage,
    totalPages,
    startIndex,
    endIndex,
  );

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationModelImplCopyWith<T, _$PaginationModelImpl<T>> get copyWith =>
      __$$PaginationModelImplCopyWithImpl<T, _$PaginationModelImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _PaginationModel<T> implements PaginationModel<T> {
  const factory _PaginationModel({
    required final List<T> data,
    final String? nextPageUrl,
    final String? previousPageUrl,
    final int totalData,
    final int pageSize,
    final int currentPage,
    final int totalPages,
    final int startIndex,
    final int endIndex,
  }) = _$PaginationModelImpl<T>;

  @override
  List<T> get data;
  @override
  String? get nextPageUrl;
  @override
  String? get previousPageUrl;
  @override
  int get totalData;
  @override
  int get pageSize;
  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  int get startIndex;
  @override
  int get endIndex;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationModelImplCopyWith<T, _$PaginationModelImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
