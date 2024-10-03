import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/features/home/data/repository/user_post_repo_impl.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';
import 'package:neighborgood/features/home/domain/usecases/user_profile_post_usecase.dart';

final userPostRepositoryProvider = Provider<UserPostRepoImpl>((ref) {
  return UserPostRepoImpl(FirebaseFirestore.instance);
});

final userPostUseCaseProvider = Provider<UserProfilePostUsecase>((ref) {
  final postRepository = ref.watch(userPostRepositoryProvider);
  return UserProfilePostUsecase(postRepository);
});

final feedListProvider = StateNotifierProvider<HomeFeedsProvider, List<PostFeedsModel>>((ref) {
  final userPostRepository = ref.watch(userPostUseCaseProvider);
  return HomeFeedsProvider(userPostRepository);
});

class HomeFeedsProvider extends StateNotifier<List<PostFeedsModel>> {
  final UserProfilePostUsecase userPostUseCase;

  HomeFeedsProvider(this.userPostUseCase) : super([]) {
    userPostUseCase('').listen((snapshot) {
      state = snapshot.docs.map((doc) => doc.data() as PostFeedsModel).toList();
    });
  }
}
