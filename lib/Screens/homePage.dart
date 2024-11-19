import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/Login Bloc/bloc.dart';
import '../Bloc/Login Bloc/event.dart';
import '../Bloc/Login Bloc/state.dart';
import '../Style/methods.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: YaziTipi("CityGuide", 20, Colors.white38),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Trigger the logout event via BLoC
              context.read<AuthBloc>().add(LogoutEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            // Navigate to login page on successful logout
            Navigator.pushReplacementNamed(context, '/signlog');
          } else if (state is AuthFailure) {
            // Show error message if logout fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error signing out: ${state.errorMessage}')),
            );
          }
        },
        child: const Center(), // You can keep designing your app from here :)
      ),
    );
  }
}
