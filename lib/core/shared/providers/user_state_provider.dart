import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/features/auth/domain/models/register_user_model.dart';

class UserStateNotifier extends StateNotifier<RegisterUserModel?> {
  UserStateNotifier() : super(null);

  void setUser(RegisterUserModel user) {
    state = user;
  }

  void logout() {
    state = null;
  }

  bool isLoggedIn() => state != null;
}

final userStateNotifierProvider = StateNotifierProvider<UserStateNotifier, RegisterUserModel?>((ref) {
  return UserStateNotifier();
});
