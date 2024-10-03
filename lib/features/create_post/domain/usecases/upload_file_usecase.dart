import 'dart:io';

import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/create_post/data/repository/create_post_repo_impl.dart';

class UploadFileUsecase {
  final CreatePostRepoImpl repository;

  UploadFileUsecase(this.repository);

  Future<AuthResponse> call(File file) async {
    try {
      return await repository.uploadPostImage(file);
    } catch (e) {
      rethrow;
    }
  }
}
