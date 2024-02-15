import 'package:flutter/material.dart';
import 'package:hobby_tracker/models/hobby.dart';
import 'package:hobby_tracker/models/user.dart';
import 'package:hobby_tracker/services/api/hobby_service.dart';
import 'package:hobby_tracker/services/api/user_service.dart';
import 'package:hobby_tracker/widgets/user_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> get userEmail async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('userEmail');
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addHobby(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addHobby(BuildContext context) async {
    // Implement your logic to add a hobby
    // For example, you might show a dialog with a text field for the hobby name
    String? hobbyName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Hobby'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Hobby Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Hobby Name');
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

    if (hobbyName != null) {
      User? user = await _userService.getCurrentUser(userEmail as String);
      int userId = user.id as int;

      // Call HobbyService to add the hobby
      await _hobbyService.addHobby(
        Hobby(id: '-1', name: hobbyName),
        userId.toString(),
      );

      // Refresh the hobby list
      setState(() {});
    }
  }
}
