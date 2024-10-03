import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUserModel {
  final String username;
  final String password;
  final String fullName;
  final int user_id;

  RegisterUserModel({
    required this.username,
    required this.password,
    required this.fullName,
    this.user_id = 0,
  });

  // Copy with functionality
  RegisterUserModel copyWith({
    String? username,
    String? password,
    String? fullName,
    int? user_id,
  }) {
    return RegisterUserModel(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {'user_id': user_id, 'username': username, 'password': password, 'full_name': fullName, 'created_at': FieldValue.serverTimestamp()};
  }

  factory RegisterUserModel.fromMap(Map<String, dynamic> map) {
    return RegisterUserModel(
      user_id: map['user_id'] ?? '',
      username: map['user_name'] ?? '',
      fullName: map['Name'] ?? '',
      password: '',
    );
  }
}
