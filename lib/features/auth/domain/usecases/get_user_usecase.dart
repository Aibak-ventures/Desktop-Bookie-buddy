import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';

class GetUserUseCase {
  final IUserRepository _repository;

  GetUserUseCase(this._repository);

  Future<UserModel> call() => _repository.fetchUserData();
}
