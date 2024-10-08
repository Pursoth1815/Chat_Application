import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/auth/domain/models/register_user_model.dart';
import 'package:neighborgood/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseFirestore firestore;

  AuthRepositoryImpl(this.firestore);

  @override
  Future<AuthResponse> checkIfUserExists(String username, String password) async {
    try {
      final query = await firestore.collection('neighborgood_user_details').where("user_name", isEqualTo: username).get();

      if (query.docs.isEmpty) {
        return AuthResponse(
          status: false,
          message: 'User not found',
        );
      }

      final userDoc = query.docs.first;
      final userData = userDoc.data();

      if (userData['password'] == password) {
        return AuthResponse(
          status: true,
          message: 'Login successful',
          responce: RegisterUserModel.fromMap(userData),
        );
      } else {
        return AuthResponse(
          status: false,
          message: 'Incorrect password',
        );
      }
    } catch (e) {
      return AuthResponse(
        status: false,
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  @override
  Future<AuthResponse> registerUser(RegisterUserModel model) async {
    try {
      final query = await firestore.collection('neighborgood_user_details').where("user_name", isEqualTo: model.username).get();

      if (query.docs.isNotEmpty) {
        return AuthResponse(
          status: false,
          message: 'User already exists.',
        );
      }
      final getLastId = await firestore.collection('neighborgood_user_details').orderBy('user_id').limitToLast(1).get();

      final userDoc = getLastId.docs.first;
      final lastInsertedID = userDoc.data();

      int UID = int.parse(lastInsertedID['user_id'].toString()) + 1;
      RegisterUserModel userList = model.copyWith(user_id: UID);

      await firestore.collection('neighborgood_user_details').add(userList.toMap());

      return AuthResponse(
        status: true,
        message: 'User created successfully.',
      );
    } catch (e) {
      print(e);
      return AuthResponse(
        status: false,
        message: 'Error creating user: $e',
      );
    }
  }
}
