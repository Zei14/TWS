import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'katakata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/katakata': (context) =>
            KataKataPage(), // Tambahkan rute untuk kata-kata
        '/home': (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Home Page'),
              ),
              body: const Center(
                child: Text('Welcome to the home page!'),
              ),
            ),
      },
    );
  }
}
