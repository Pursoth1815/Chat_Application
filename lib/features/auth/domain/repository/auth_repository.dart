import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/auth/domain/models/register_user_model.dart';

abstract class AuthRepository {
  Future<AuthResponse> checkIfUserExists(String username, String password);
  Future<AuthResponse> registerUser(RegisterUserModel model);
}
