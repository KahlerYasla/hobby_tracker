import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: const Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
