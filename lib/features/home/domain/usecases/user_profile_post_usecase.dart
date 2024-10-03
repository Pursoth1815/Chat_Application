import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborgood/features/home/data/repository/user_post_repo_impl.dart';

class UserProfilePostUsecase {
  final UserPostRepoImpl repository;

  UserProfilePostUsecase(this.repository);

  Stream<QuerySnapshot> call(String userId) {
    try {
      return repository.fetchUserPost(userId);
    } catch (e) {
      rethrow;
    }
  }
}
