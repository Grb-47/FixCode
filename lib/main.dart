import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'start_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'language_practice_page.dart';
import 'document_list_page.dart';
import 'admin_panel_page.dart';
import 'mentor_panel_page.dart';
import 'profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FixCodeApp());
}

class FixCodeApp extends StatelessWidget {
  const FixCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String initialRoute = user != null ? '/home' : '/';

    return MaterialApp(
      title: 'FixCode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => StartPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => HomePage(),
        '/practice': (context) => LanguagePracticePage(),
        '/documents': (context) => DocumentListPage(),
        '/admin': (context) => const AdminPanelPage(),
        '/mentor': (context) => const MentorPanelPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
