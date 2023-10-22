import 'package:englishlearning_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('An error occurred while signing in.'),
      actions: [
        TextButton(
          onPressed: () {
            context
                .read<UserBloc>()
                .add(const UserEvent.signIn(password: '', email: ''));
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
