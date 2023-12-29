import 'package:englishlearning_app/data/repository/auth_repository.dart';
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

class SignInScreen extends StatelessWidget {
  final UserBloc userBloc = UserBloc(authRepository: AuthRepository());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInScreen({Key? key}) : super(key: key);

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
                AppRoutes.homeScreen,
              );
            },
          );
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Lottie.asset(
                          'assets/animations/signin.json',
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
                        controller: _passwordController,
                        text: S.of(context).password,
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0),
                      AppButton(
                        text: (S.of(context).signIn),
                        onPressed: () {
                          context.read<UserBloc>().add(
                                UserEvent.signIn(
                                  email: _emailController.text,
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
                              AppRoutes.signUpScreen,
                            );
                          },
                          child: Text(
                            S.of(context).doNotHaveAnAccountSignUp,
                            style: TextStyle(
                              color: Colors.orange.shade300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              state.maybeWhen(
                orElse: () => const SizedBox(),
                loading: () {
                  return Lottie.asset('assets/animations/loading.json');
                },
                error: () => ErrorDialog(
                  errorMessage: S.of(context).emailOrPasswordIsIncorrect,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
