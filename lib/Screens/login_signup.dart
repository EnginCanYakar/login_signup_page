import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip_card/flip_card.dart';
import '../Bloc/Login Bloc/bloc.dart';
import '../Bloc/Login Bloc/event.dart';
import '../Bloc/Login Bloc/state.dart';
import '../Style/methods.dart';

class SignUpLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FlipCardState> _flipCardKey = GlobalKey<FlipCardState>();

  SignUpLoginPage({super.key});

  // Register user
  void registerUser(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignupEvent(
        _emailController.text,
        _passwordController.text,
      ),
    );
  }

  // Log in user
  void loginUser(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        _emailController.text,
        _passwordController.text,
      ),
    );
  }

  // Flip the card to show the login page
  void flipToLoginPage() {
    _flipCardKey.currentState?.toggleCard();
  }

  // Flip the card to show the signup page
  void flipToSignUpPage() {
    _flipCardKey.currentState?.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0B0B),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlipCard(
                    key: _flipCardKey,
                    direction: FlipDirection.HORIZONTAL,
                    front: Card(
                      shadowColor: Colors.grey.withOpacity(0.8),
                      elevation: 60,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.login,
                              color: Colors.white,
                              size: 70,
                            ),

                            YaziTipi("Log In", 30, Colors.white),
                            const SizedBox(
                              height: 15,
                            ),
                            YaziTipi("Hello, It's Great to See You Again!", 20,
                                Colors.white),
                            const SizedBox(height: 20),
                            // Email TextField
                            TextfildController(
                              controller: _emailController,
                              label: "Enter your email",
                              password: false,
                            ),
                            const SizedBox(height: 20),
                            // Password TextField
                            TextfildController(
                              controller: _passwordController,
                              label: "Password",
                              password: true,
                            ),
                            const SizedBox(height: 20),
                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  elevation: 20,
                                  backgroundColor: Colors.grey[850],
                                ),
                                onPressed: () => loginUser(context),
                                child: YaziTipi("Log In", 20, Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Flip to sign-up
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have a profile?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: flipToSignUpPage,
                                  child: YaziTipi("Sign Up", 20, Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    back: Card(
                      shadowColor: Colors.grey.withOpacity(0.8),
                      elevation: 60,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person_add,
                              color: Colors.white,
                              size: 70,
                            ),
                            YaziTipi("Sign Up", 30, Colors.white),
                            const SizedBox(height: 15),
                            YaziTipi("Hello, Welcome for New Adventures!", 20,
                                Colors.white),
                            const SizedBox(height: 20),
                            // Name TextField
                            TextfildController(
                              controller: _nameController,
                              label: "Enter your Name",
                              password: false,
                            ),
                            const SizedBox(height: 20),
                            // Email TextField
                            TextfildController(
                              controller: _emailController,
                              label: "Enter your email",
                              password: false,
                            ),
                            const SizedBox(height: 20),
                            // Password TextField
                            TextfildController(
                              controller: _passwordController,
                              label: "Password",
                              password: true,
                            ),
                            const SizedBox(height: 20),
                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  elevation: 20,
                                  backgroundColor: Colors.grey[850],
                                ),
                                onPressed: () => registerUser(context),
                                child: YaziTipi("Sign Up", 20, Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Flip to login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have a profile?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: flipToLoginPage,
                                  child: YaziTipi("Log In", 20, Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
