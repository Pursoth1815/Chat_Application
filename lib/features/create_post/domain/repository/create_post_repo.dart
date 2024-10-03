import 'dart:io';

import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/create_post/domain/models/create_post_model.dart';

abstract class CreatePostRepository {
  Future<AuthResponse> createPost(CreatePostModel post);
  Future<AuthResponse> uploadPostImage(File file);
}
