import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/home/data/repository/user_post_repo_impl.dart';
import 'package:neighborgood/features/home/presentation/providers/post_feed_provider.dart';

class ActionBtnTriggerUsecase {
  final UserPostRepoImpl repository;

  ActionBtnTriggerUsecase(this.repository);

  Future<AuthResponse> call(ActionBtn action, int post_id) async {
    try {
      return await repository.TriggerAction(action, post_id);
    } catch (e) {
      rethrow;
    }
  }
}
