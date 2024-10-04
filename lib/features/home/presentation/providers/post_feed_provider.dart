import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/home/data/repository/user_post_repo_impl.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';
import 'package:neighborgood/features/home/domain/usecases/action_btn_trigger_usecase.dart';
import 'package:neighborgood/features/home/domain/usecases/user_profile_post_usecase.dart';

final userPostRepositoryProvider = Provider<UserPostRepoImpl>((ref) {
  return UserPostRepoImpl(FirebaseFirestore.instance);
});

final userPostUseCaseProvider = Provider<UserProfilePostUsecase>((ref) {
  final postRepository = ref.watch(userPostRepositoryProvider);
  return UserProfilePostUsecase(postRepository);
});

final actionBtnUseCaseProvider = Provider<ActionBtnTriggerUsecase>((ref) {
  final postRepository = ref.watch(userPostRepositoryProvider);
  return ActionBtnTriggerUsecase(postRepository);
});

final feedListProvider = StateNotifierProvider<HomeFeedsProvider, List<PostFeedsModel>>((ref) {
  final userPostRepository = ref.watch(userPostUseCaseProvider);
  final actionBtnRepository = ref.watch(actionBtnUseCaseProvider);
  return HomeFeedsProvider(userPostRepository, actionBtnRepository);
});

class HomeFeedsProvider extends StateNotifier<List<PostFeedsModel>> {
  final UserProfilePostUsecase userPostUseCase;
  final ActionBtnTriggerUsecase actionBtnUseCase;

  HomeFeedsProvider(this.userPostUseCase, this.actionBtnUseCase) : super([]) {
    userPostUseCase('').listen((snapshot) {
      state = snapshot.docs.map((doc) => doc.data() as PostFeedsModel).toList();
    });
  }

  Future<AuthResponse> actionButtonsTrigger(ActionBtn action, int post_id) async {
    try {
      return await actionBtnUseCase.call(action, post_id);
    } catch (e) {
      rethrow;
    }
  }
}

enum ActionBtn { like, save }
