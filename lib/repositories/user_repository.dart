import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby_tracker/models/user.dart';

class UserRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<User> getCurrentUser(String email) async {
    DocumentSnapshot snapshot = (await _usersCollection
        .where('email', isEqualTo: email)
        .get()) as DocumentSnapshot;
    if (snapshot.exists) {
      return User.fromMap(snapshot.data() as Map<String, dynamic>);
    } else {
      return User(
        id: '-1',
        name: 'no name',
        surname: 'no surname',
        email: 'no email',
        birthdate: DateTime.now(),
        bio: 'no bio',
      );
    }
  }

  Future<bool> createUser(User user) async {
    await _usersCollection.add(
      user.toMap(user),
    );

    return true;
  }

  Future<void> signOut() async {}
}
