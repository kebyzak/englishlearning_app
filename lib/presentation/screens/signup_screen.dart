import 'package:englishlearning_app/generated/l10n.dart';
import 'package:englishlearning_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:englishlearning_app/presentation/widgets/app_button.dart';
import 'package:englishlearning_app/presentation/widgets/error_dialog.dart';
import 'package:englishlearning_app/presentation/widgets/text_field.dart';
import 'package:englishlearning_app/router/app_routes.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: () {
              Navigator.pushNamed(
                context,
                AppRoutes.signInScreen,
              );
            },
            error: () {
              showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(errorMessage: S.of(context).error),
              );
            },
            loading: () {
              showDialog(
                context: context,
                builder: (context) =>
                    Lottie.asset('assets/animations/loading.json'),
              );
            },
          );
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/animations/signup.json',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  MyTextField(
                    controller: _emailController,
                    text: S.of(context).email,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _nameController,
                    text: S.of(context).name,
                  ),
                  const SizedBox(height: 12),
                  MyTextField(
                    controller: _passwordController,
                    text: S.of(context).password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  AppButton(
                    text: S.of(context).signUp,
                    onPressed: () {
                      context.read<UserBloc>().add(
                            UserEvent.signUp(
                              email: _emailController.text,
                              name: _nameController.text,
                              password: _passwordController.text,
                            ),
                          );
                    },
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.signInScreen,
                        );
                      },
                      child: Text(
                        S.of(context).alreadyHaveAnAccountSignIn,
                        style: TextStyle(
                          color: Colors.orange.shade300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
