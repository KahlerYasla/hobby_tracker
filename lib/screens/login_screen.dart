import 'package:flutter/material.dart';
import 'package:hobby_tracker/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hobby_tracker/services/api/user_service.dart';

class LoginScreen extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _emailController = TextEditingController();

  LoginScreen({super.key});

  Future<void> _signIn(BuildContext context) async {
    final String email = _emailController.text.trim();
    final UserService userService =
        UserService(); // Create an instance of your UserService

    final User user = await userService.getCurrentUser(email);
    final int userId = int.parse(user.id);

    if (userId == -1) {
      // Show a dialog for wrong email
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Wrong Email'),
          content: Text('The provided email is incorrect.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Save user email and sign-in status in SharedPreferences
      final SharedPreferences prefs = await _prefs;
      await prefs.setString('userEmail', email);
      await prefs.setBool('isSignedIn', true);

      // Navigate to the home screen
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'You need to be signed in to use this application',
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextButton.icon(
              onPressed: () => _signIn(context),
              icon: const Icon(Icons.login),
              label: const Text('SIGN IN'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('REGISTER'),
            ),
          ],
        ),
      ),
    );
  }
}
