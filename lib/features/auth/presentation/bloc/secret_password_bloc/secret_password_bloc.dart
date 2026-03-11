import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_secret_password_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret_password_event.dart';
part 'secret_password_state.dart';
part 'secret_password_bloc.freezed.dart';

class SecretPasswordBloc
    extends Bloc<SecretPasswordEvent, SecretPasswordState> {
  final ChangeSecretPasswordUseCase _changeSecretPassword;

  SecretPasswordBloc(
      {required ChangeSecretPasswordUseCase changeSecretPassword})
      : _changeSecretPassword = changeSecretPassword,
        super(const _Initial()) {
    on<SecretPasswordEvent>((event, emit) async {
      emit(const _Loading());

      try {
        await _changeSecretPassword.call(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        );

        emit(const _Success());
      } catch (e) {
        emit(_Failure(e.toString()));
      }
    });
  }

  bool get isLoading => state is _Loading;
}
