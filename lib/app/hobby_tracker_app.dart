import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hobby_tracker/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hobby_tracker/screens/home_screen.dart';
import 'package:hobby_tracker/screens/login_screen.dart';

class HobbyTrackerApp extends StatelessWidget {
  HobbyTrackerApp({super.key});

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> get isSignedIn async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isSignedIn') ?? false;
  }

  Future<String?> get userEmail async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('userEmail');
  }

  Future<void> setSignInStatus(bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isSignedIn', value);
  }

  Future<void> setUserEmail(String email) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('userEmail', email);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XFF101114),
      systemNavigationBarColor: Color(0XFF101114),
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0XFFFF7083),
          primary: const Color(0XFFFF7083),
          brightness: Brightness.dark,
          background: const Color(0XFF101114),
        ),
        useMaterial3: true,
        fontFamily: 'UbuntuMono',
      ),
      home: FutureBuilder<bool>(
        future: isSignedIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            bool isSignedIn = snapshot.data ?? false;
            return Scaffold(
              body: SafeArea(
                child: Scaffold(
                  body: isSignedIn ? const HomeScreen() : LoginScreen(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
