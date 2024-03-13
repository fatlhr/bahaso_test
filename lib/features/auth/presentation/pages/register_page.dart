// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:bahaso_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bahaso_test/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static route() =>
      MaterialPageRoute(builder: (context) => const RegisterPage());
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(
                context,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error,
                      size: 24.0,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8.0),
                    Text(state.message)
                  ],
                ),
              );
            } else if (state is AuthSuccess) {
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   HomePage.route(),
              //   (route) => false,
              // );
              showSnackBar(
                context,
                const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 24.0,
                      color: Colors.green,
                    ),
                    Text(" Account Successfully Registred!"),
                  ],
                ),
              );
              emailController.clear();
              passwordController.clear();
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register.',
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
                  AuthButton(
                    buttonText: 'Register',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthRegister(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, LoginPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Login Here!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
