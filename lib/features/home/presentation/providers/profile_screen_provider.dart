import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/features/create_post/domain/models/create_post_model.dart';
import 'package:neighborgood/features/home/data/repository/user_post_repo_impl.dart';
import 'package:neighborgood/features/home/domain/usecases/user_profile_post_usecase.dart';

final userPostRepositoryProvider = Provider<UserPostRepoImpl>((ref) {
  return UserPostRepoImpl(FirebaseFirestore.instance);
});

final userPostUseCaseProvider = Provider<UserProfilePostUsecase>((ref) {
  final postRepository = ref.watch(userPostRepositoryProvider);
  return UserProfilePostUsecase(postRepository);
});

final ProfileProvider = StateNotifierProvider<UserPostProvider, List<CreatePostModel>>((ref) {
  final userPostRepository = ref.watch(userPostUseCaseProvider);
  return UserPostProvider(userPostRepository);
});

class UserPostProvider extends StateNotifier<List<CreatePostModel>> {
  final UserProfilePostUsecase userPostUseCase;

  UserPostProvider(this.userPostUseCase) : super([]) {
    userPostUseCase().listen((snapshot) {
      state = snapshot.docs.map((doc) => doc.data() as CreatePostModel).toList();
    });
  }
}
