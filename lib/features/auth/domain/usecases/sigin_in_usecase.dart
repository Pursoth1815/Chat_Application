import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/auth/data/repository/auth_repository_impl.dart';

class SignInUseCase {
  final AuthRepositoryImpl repository;

  SignInUseCase(this.repository);

  Future<AuthResponse> call(String username, String password) async {
    try {
      return await repository.checkIfUserExists(username, password);
    } catch (e) {
      rethrow;
    }
  }
}
