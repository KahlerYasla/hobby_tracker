import 'package:flutter/material.dart';
import 'package:hobby_tracker/models/hobby.dart';
import 'package:hobby_tracker/models/user.dart';
import 'package:hobby_tracker/services/api/hobby_service.dart';
import 'package:hobby_tracker/services/api/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HobbyService _hobbyService = HobbyService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          UserCard(userService: _userService),
          Expanded(
            child: FutureBuilder<List<Hobby>>(
              future: _hobbyService.getAllHobbies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Hobby> hobbies = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: hobbies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(hobbies[index].name),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserService userService;

  const UserCard({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: userService.getCurrentUser() as Future<User>?,
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
