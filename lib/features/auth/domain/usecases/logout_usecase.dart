import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';

class LogoutUseCase {
  final IUserRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call({String? fcmToken}) => _repository.logout(fcmToken: fcmToken);
}
