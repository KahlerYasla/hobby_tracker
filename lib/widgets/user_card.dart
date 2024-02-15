import 'package:flutter/material.dart';
import 'package:hobby_tracker/models/user.dart';
import 'package:hobby_tracker/services/api/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCard extends StatelessWidget {
  final UserService userService;

  UserCard({super.key, required this.userService});

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> get userEmail async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('userEmail');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: userService.getCurrentUser(userEmail as String),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          User user = snapshot.data!;
          return Card(
            child: ListTile(
              title: Text('${user.name} ${user.surname}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user.email}'),
                  Text('Birthdate: ${user.birthdate}'),
                  Text('Bio: ${user.bio}'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
