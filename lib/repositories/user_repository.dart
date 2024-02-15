import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby_tracker/models/user.dart';

class UserRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<User> getCurrentUser(String email) async {
    DocumentSnapshot snapshot = (await _usersCollection
        .where('email', isEqualTo: email)
        .get()) as DocumentSnapshot;
    return User.fromMap(
      snapshot.data() as Map<String, dynamic>,
    );
  }

  Future<void> signOut() async {}
}
