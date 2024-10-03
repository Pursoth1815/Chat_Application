import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserProfilePostRepo {
  Stream<QuerySnapshot> fetchUserPost();
}
