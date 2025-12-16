import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/features/change_password/repository/change_password_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret_password_event.dart';
part 'secret_password_state.dart';
part 'secret_password_bloc.freezed.dart';

class SecretPasswordBloc
    extends Bloc<SecretPasswordEvent, SecretPasswordState> {
  final ChangePasswordRepository _repository =
      getIt<ChangePasswordRepository>();

  SecretPasswordBloc({required Object repository}) : super(const _Initial()) {
    on<SecretPasswordEvent>((event, emit) async {
      emit(const _Loading());

      try {
        await _repository.changeSecretPassword(
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
