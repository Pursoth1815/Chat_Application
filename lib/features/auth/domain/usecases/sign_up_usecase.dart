import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/auth/data/repository/auth_repository_impl.dart';
import 'package:neighborgood/features/auth/domain/models/register_user_model.dart';

class SignUpUseCase {
  final AuthRepositoryImpl repository;

  SignUpUseCase(this.repository);

  Future<AuthResponse> call(RegisterUserModel model) async {
    try {
      return await repository.registerUser(model);
    } catch (e) {
      rethrow;
    }
  }
}
