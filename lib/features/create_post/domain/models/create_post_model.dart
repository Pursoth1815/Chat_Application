import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostModel {
  String title;
  String description;
  String post_image_path;

  CreatePostModel({
    required this.title,
    required this.description,
    required this.post_image_path,
  });

  CreatePostModel copyWith({
    String? title,
    String? description,
    DateTime? created_at,
    String? post_image_path,
  }) {
    return CreatePostModel(
      title: title ?? this.title,
      description: description ?? this.description,
      post_image_path: post_image_path ?? this.post_image_path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'created_at': FieldValue.serverTimestamp(),
      'post_image_path': post_image_path,
    };
  }

  factory CreatePostModel.fromMap(Map<String, dynamic> map) {
    return CreatePostModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      post_image_path: map['post_image_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePostModel.fromJson(String source) => CreatePostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreatePostModel(title: $title, description: $description, post_image_path: $post_image_path)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatePostModel && other.title == title && other.description == description && other.post_image_path == post_image_path;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ post_image_path.hashCode;
  }
}
