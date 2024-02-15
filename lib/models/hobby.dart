import 'package:firebase_auth/firebase_auth.dart';

class Hobby {
  final String id;
  final String name;
  List<User> users;

  Hobby({required this.id, required this.name, this.users = const []});

  static Hobby fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw FirebaseAuthException(
        message: 'No data',
        code: 'no-data',
      );
    }

    final String id = data['id'];
    final String name = data['name'];
    final List<User> users = data['users'];

    return Hobby(id: id, name: name, users: users);
  }

  Map<String, dynamic> toMap(Hobby hobby) {
    return {
      'id': hobby.id,
      'name': hobby.name,
      'users': hobby.users,
    };
  }
}
