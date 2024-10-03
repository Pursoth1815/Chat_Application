import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/create_post/domain/models/create_post_model.dart';
import 'package:neighborgood/features/create_post/domain/repository/create_post_repo.dart';

class CreatePostRepoImpl implements CreatePostRepository {
  final FirebaseFirestore firestore;

  CreatePostRepoImpl(this.firestore);

  @override
  Future<AuthResponse> createPost(CreatePostModel model) async {
    try {
      await firestore.collection('neighborgood_feeds').add(model.toMap());

      return AuthResponse(
        status: true,
        message: 'Post saved successfully.',
      );
    } catch (e) {
      return AuthResponse(
        status: false,
        message: 'Error creating user: $e',
      );
    }
  }

  @override
  Future<AuthResponse> uploadPostImage(File file) async {
    try {
      String? fileExtension;
      const int maxSizeInBytes = 10 * 1024 * 1024;

      final int fileSize = await file.length();

      if (fileSize > maxSizeInBytes) {
        return AuthResponse(status: false, message: 'File size exceeds 10MB.');
      }
      final mimeType = lookupMimeType(file.path);

      if (mimeType == 'image/jpeg') {
        fileExtension = 'jpg';
      } else if (mimeType == 'image/png') {
        fileExtension = 'png';
      } else {
        return AuthResponse(status: false, message: 'Unsupported file format. Only JPG and PNG are allowed.');
      }

      final storageRef = FirebaseStorage.instance.ref();

      final imageRef = storageRef.child('Post_Attachments/${DateTime.now().millisecondsSinceEpoch}.$fileExtension');

      final uploadTask = imageRef.putFile(file);

      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      return AuthResponse(status: true, message: imageUrl);
    } catch (e) {
      return AuthResponse(
        status: false,
        message: 'Error creating post: $e',
      );
    }
  }
}
