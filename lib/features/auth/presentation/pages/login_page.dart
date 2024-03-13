// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:bahaso_test/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: const [],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In.',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    child: const Text("Login"),
                  ),
                  // AuthGradientButton(
                  //   buttonText: 'Sign in',
                  //   onPressed: () {
                  //     if (formKey.currentState!.validate()) {
                  //       context.read<AuthBloc>().add(
                  //             AuthLogin(
                  //               email: emailController.text.trim(),
                  //               password: passwordController.text.trim(),
                  //             ),
                  //           );
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 20),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context, SignUpPage.route());
                  //   },
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: 'Don\'t have an account? ',
                  //       style: Theme.of(context).textTheme.titleMedium,
                  //       children: [
                  //         TextSpan(
                  //           text: 'Sign Up',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium
                  //               ?.copyWith(
                  //                 color: AppPallete.gradient2,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
}
