import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/Login Bloc/bloc.dart';
import 'Screens/homePage.dart';
import 'Screens/login_signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => AuthBloc(FirebaseAuth.instance),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/signlog': (context) => SignUpLoginPage(),
        '/home': (context) => const Homepage(),
      },
      // Wrap the MaterialApp widget with BlocProvider for AuthBloc
      home: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(FirebaseAuth.instance),
        child: SignUpLoginPage(),
      ),
    );
  }
}
