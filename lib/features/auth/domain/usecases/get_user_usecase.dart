import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';

class GetUserUseCase {
  final IUserRepository _repository;

  GetUserUseCase(this._repository);

  Future<UserEntity> call() => _repository.fetchUserData();
}
