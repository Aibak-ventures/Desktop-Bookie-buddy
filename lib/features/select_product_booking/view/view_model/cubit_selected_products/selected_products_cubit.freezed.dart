// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_products_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SelectedProductsState {
  List<ProductSelectedModel> get selectedProductsWithAmount =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<ProductSelectedModel> selectedProductsWithAmount,
    )
    selected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ProductSelectedModel> selectedProductsWithAmount)?
    selected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ProductSelectedModel> selectedProductsWithAmount)?
    selected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Selected value) selected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Selected value)? selected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of SelectedProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedProductsStateCopyWith<SelectedProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedProductsStateCopyWith<$Res> {
  factory $SelectedProductsStateCopyWith(
    SelectedProductsState value,
    $Res Function(SelectedProductsState) then,
  ) = _$SelectedProductsStateCopyWithImpl<$Res, SelectedProductsState>;
  @useResult
  $Res call({List<ProductSelectedModel> selectedProductsWithAmount});
}

/// @nodoc
class _$SelectedProductsStateCopyWithImpl<
  $Res,
  $Val extends SelectedProductsState
>
    implements $SelectedProductsStateCopyWith<$Res> {
  _$SelectedProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedProductsWithAmount = null}) {
    return _then(
      _value.copyWith(
            selectedProductsWithAmount: null == selectedProductsWithAmount
                ? _value.selectedProductsWithAmount
                : selectedProductsWithAmount // ignore: cast_nullable_to_non_nullable
                      as List<ProductSelectedModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectedImplCopyWith<$Res>
    implements $SelectedProductsStateCopyWith<$Res> {
  factory _$$SelectedImplCopyWith(
    _$SelectedImpl value,
    $Res Function(_$SelectedImpl) then,
  ) = __$$SelectedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProductSelectedModel> selectedProductsWithAmount});
}

/// @nodoc
class __$$SelectedImplCopyWithImpl<$Res>
    extends _$SelectedProductsStateCopyWithImpl<$Res, _$SelectedImpl>
    implements _$$SelectedImplCopyWith<$Res> {
  __$$SelectedImplCopyWithImpl(
    _$SelectedImpl _value,
    $Res Function(_$SelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectedProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedProductsWithAmount = null}) {
    return _then(
      _$SelectedImpl(
        null == selectedProductsWithAmount
            ? _value._selectedProductsWithAmount
            : selectedProductsWithAmount // ignore: cast_nullable_to_non_nullable
                  as List<ProductSelectedModel>,
      ),
    );
  }
}

/// @nodoc

class _$SelectedImpl implements _Selected {
  const _$SelectedImpl(
    final List<ProductSelectedModel> selectedProductsWithAmount,
  ) : _selectedProductsWithAmount = selectedProductsWithAmount;

  final List<ProductSelectedModel> _selectedProductsWithAmount;
  @override
  List<ProductSelectedModel> get selectedProductsWithAmount {
    if (_selectedProductsWithAmount is EqualUnmodifiableListView)
      return _selectedProductsWithAmount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedProductsWithAmount);
  }

  @override
  String toString() {
    return 'SelectedProductsState.selected(selectedProductsWithAmount: $selectedProductsWithAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedImpl &&
            const DeepCollectionEquality().equals(
              other._selectedProductsWithAmount,
              _selectedProductsWithAmount,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selectedProductsWithAmount),
  );

  /// Create a copy of SelectedProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedImplCopyWith<_$SelectedImpl> get copyWith =>
      __$$SelectedImplCopyWithImpl<_$SelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<ProductSelectedModel> selectedProductsWithAmount,
    )
    selected,
  }) {
    return selected(selectedProductsWithAmount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ProductSelectedModel> selectedProductsWithAmount)?
    selected,
  }) {
    return selected?.call(selectedProductsWithAmount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ProductSelectedModel> selectedProductsWithAmount)?
    selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(selectedProductsWithAmount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Selected value) selected,
  }) {
    return selected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Selected value)? selected,
  }) {
    return selected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(this);
    }
    return orElse();
  }
}

abstract class _Selected implements SelectedProductsState {
  const factory _Selected(
    final List<ProductSelectedModel> selectedProductsWithAmount,
  ) = _$SelectedImpl;

  @override
  List<ProductSelectedModel> get selectedProductsWithAmount;

  /// Create a copy of SelectedProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedImplCopyWith<_$SelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
