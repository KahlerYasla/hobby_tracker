import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hobby_tracker/repositories/user_repository.dart';
import 'package:hobby_tracker/screens/home_screen.dart';
import 'package:hobby_tracker/screens/login_screen.dart';

class HobbyTrackerApp extends StatelessWidget {
  const HobbyTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XFF101114),
      systemNavigationBarColor: Color(0XFF101114),
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
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
      home: Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: StreamBuilder<bool>(
              initialData: false,
              stream: authStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Center(child: Text('Something went wrong'));
                } else {
                  final signedIn = snapshot.data ?? false;
                  return signedIn ? HomeScreen() : const LoginScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
