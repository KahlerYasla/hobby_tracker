import 'package:flutter/material.dart';
import 'package:hobby_tracker/models/user.dart';
import 'package:hobby_tracker/services/api/user_service.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final UserService _userService = UserService();

  Future<void> _register(BuildContext context) async {
    // Get values from controllers
    final String name = _nameController.text.trim();
    final String surname = _surnameController.text.trim();
    final String email = _emailController.text.trim();
    final String birthdate = _birthdateController.text.trim();
    final String bio = _bioController.text.trim();

    // Validate input
    if (name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        birthdate.isEmpty ||
        bio.isEmpty) {
      return;
    }

    // Perform user registration
    final bool registrationResult = await _userService.createUser(
      User(
        id: '-1', // You can use any value here, as it will be ignored
        name: name,
        surname: surname,
        email: email,
        birthdate: DateTime.parse(birthdate),
        bio: bio,
      ),
    );

    if (registrationResult) {
      // Registration successful, navigate back to login screen
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Registration failed, show an error message (you can customize this)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Failed'),
          content:
              Text('An error occurred during registration. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _surnameController,
              decoration: InputDecoration(labelText: 'Surname'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _birthdateController,
              decoration: InputDecoration(labelText: 'Birthdate'),
              keyboardType:
                  TextInputType.datetime, // You might want to use a date picker
            ),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
