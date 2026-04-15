import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petsync/view/home_view.dart';
import 'package:petsync/view/login_view.dart';
import 'package:petsync/view/register_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PetSyncApp());
}

class PetSyncApp extends StatelessWidget {
  const PetSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueAccent),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}