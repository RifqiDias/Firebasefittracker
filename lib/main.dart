import 'package:firebase_core/firebase_core.dart';
import 'package:firebasefittracker/firebase_options.dart';
import 'package:firebasefittracker/main_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter fit-Tracker',
      home: MainPage(),
    );
  }
}
