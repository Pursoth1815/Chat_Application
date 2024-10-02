import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUserModel {
  final String username;
  final String password;
  final String fullName;

  RegisterUserModel({
    required this.username,
    required this.password,
    required this.fullName,
  });

  // Copy with functionality
  RegisterUserModel copyWith({
    String? username,
    String? password,
    String? fullName,
  }) {
    return RegisterUserModel(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password, 'full_name': fullName, 'created_at': FieldValue.serverTimestamp()};
  }
}
