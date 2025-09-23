part of 'transfer_product_cubit.dart';

@freezed
class TransferProductState with _$TransferProductState {
  const factory TransferProductState.initial() = _Initial;
  const factory TransferProductState.transferring() = _Transferring;
  const factory TransferProductState.success(
    String message,
  ) = _Success;
  const factory TransferProductState.failure(String message) = _Failure;
}
