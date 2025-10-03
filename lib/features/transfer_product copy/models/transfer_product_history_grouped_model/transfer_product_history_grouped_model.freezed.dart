// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_product_history_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransferProductHistoryGroupedModel {
  String get date => throw _privateConstructorUsedError;
  List<TransferProductHistoryModel> get transferProductHistoryList =>
      throw _privateConstructorUsedError;

  /// Create a copy of TransferProductHistoryGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferProductHistoryGroupedModelCopyWith<
    TransferProductHistoryGroupedModel
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferProductHistoryGroupedModelCopyWith<$Res> {
  factory $TransferProductHistoryGroupedModelCopyWith(
    TransferProductHistoryGroupedModel value,
    $Res Function(TransferProductHistoryGroupedModel) then,
  ) =
      _$TransferProductHistoryGroupedModelCopyWithImpl<
        $Res,
        TransferProductHistoryGroupedModel
      >;
  @useResult
  $Res call({
    String date,
    List<TransferProductHistoryModel> transferProductHistoryList,
  });
}

/// @nodoc
class _$TransferProductHistoryGroupedModelCopyWithImpl<
  $Res,
  $Val extends TransferProductHistoryGroupedModel
>
    implements $TransferProductHistoryGroupedModelCopyWith<$Res> {
  _$TransferProductHistoryGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferProductHistoryGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? transferProductHistoryList = null}) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            transferProductHistoryList: null == transferProductHistoryList
                ? _value.transferProductHistoryList
                : transferProductHistoryList // ignore: cast_nullable_to_non_nullable
                      as List<TransferProductHistoryModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransferProductHistoryGroupedModelImplCopyWith<$Res>
    implements $TransferProductHistoryGroupedModelCopyWith<$Res> {
  factory _$$TransferProductHistoryGroupedModelImplCopyWith(
    _$TransferProductHistoryGroupedModelImpl value,
    $Res Function(_$TransferProductHistoryGroupedModelImpl) then,
  ) = __$$TransferProductHistoryGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    List<TransferProductHistoryModel> transferProductHistoryList,
  });
}

/// @nodoc
class __$$TransferProductHistoryGroupedModelImplCopyWithImpl<$Res>
    extends
        _$TransferProductHistoryGroupedModelCopyWithImpl<
          $Res,
          _$TransferProductHistoryGroupedModelImpl
        >
    implements _$$TransferProductHistoryGroupedModelImplCopyWith<$Res> {
  __$$TransferProductHistoryGroupedModelImplCopyWithImpl(
    _$TransferProductHistoryGroupedModelImpl _value,
    $Res Function(_$TransferProductHistoryGroupedModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferProductHistoryGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? transferProductHistoryList = null}) {
    return _then(
      _$TransferProductHistoryGroupedModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        transferProductHistoryList: null == transferProductHistoryList
            ? _value._transferProductHistoryList
            : transferProductHistoryList // ignore: cast_nullable_to_non_nullable
                  as List<TransferProductHistoryModel>,
      ),
    );
  }
}

/// @nodoc

class _$TransferProductHistoryGroupedModelImpl
    implements _TransferProductHistoryGroupedModel {
  const _$TransferProductHistoryGroupedModelImpl({
    required this.date,
    required final List<TransferProductHistoryModel> transferProductHistoryList,
  }) : _transferProductHistoryList = transferProductHistoryList;

  @override
  final String date;
  final List<TransferProductHistoryModel> _transferProductHistoryList;
  @override
  List<TransferProductHistoryModel> get transferProductHistoryList {
    if (_transferProductHistoryList is EqualUnmodifiableListView)
      return _transferProductHistoryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transferProductHistoryList);
  }

  @override
  String toString() {
    return 'TransferProductHistoryGroupedModel(date: $date, transferProductHistoryList: $transferProductHistoryList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferProductHistoryGroupedModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(
              other._transferProductHistoryList,
              _transferProductHistoryList,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    const DeepCollectionEquality().hash(_transferProductHistoryList),
  );

  /// Create a copy of TransferProductHistoryGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferProductHistoryGroupedModelImplCopyWith<
    _$TransferProductHistoryGroupedModelImpl
  >
  get copyWith =>
      __$$TransferProductHistoryGroupedModelImplCopyWithImpl<
        _$TransferProductHistoryGroupedModelImpl
      >(this, _$identity);
}

abstract class _TransferProductHistoryGroupedModel
    implements TransferProductHistoryGroupedModel {
  const factory _TransferProductHistoryGroupedModel({
    required final String date,
    required final List<TransferProductHistoryModel> transferProductHistoryList,
  }) = _$TransferProductHistoryGroupedModelImpl;

  @override
  String get date;
  @override
  List<TransferProductHistoryModel> get transferProductHistoryList;

  /// Create a copy of TransferProductHistoryGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferProductHistoryGroupedModelImplCopyWith<
    _$TransferProductHistoryGroupedModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
