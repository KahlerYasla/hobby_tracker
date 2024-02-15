import 'package:hobby_tracker/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'You need to be signed in to use this application',
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
            ),
          ),
          TextButton.icon(
            onPressed: signIn,
            icon: const Icon(Icons.person),
            label: const Text('GOOGLE SIGN IN'),
          ),
        ]),
      ),
    );
  }
}
