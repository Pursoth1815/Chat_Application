import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/create_post/data/repository/create_post_repo_impl.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';

class CreatePostUseCase {
  final CreatePostRepoImpl repository;

  CreatePostUseCase(this.repository);

  Future<AuthResponse> call(PostFeedsModel post) async {
    try {
      return await repository.createPost(post);
    } catch (e) {
      rethrow;
    }
  }
}
