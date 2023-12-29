import 'package:englishlearning_app/presentation/bloc/word_bloc/word_bloc.dart';
import 'package:englishlearning_app/presentation/widgets/circle_button.dart';
import 'package:englishlearning_app/presentation/widgets/error_dialog.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String capitalizeWord(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

class WordBottomSheet extends StatelessWidget {
  final String word;
  const WordBottomSheet({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        return SizedBox(
          height: 250,
          child: Center(
            child: state.maybeWhen(
              orElse: () => const SizedBox(),
              success: (definitions, audioUrl) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          capitalizeWord(word),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        definitions.join(', '),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleButton(
                            onPressed: () {
                              print("listened");
                            },
                            icon: Icons.volume_up_rounded,
                            color: Colors.deepPurpleAccent,
                          ),
                          CircleButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icons.bookmark_add,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              loading: () => Lottie.asset('assets/animations/loading.json'),
              error: () => const ErrorDialog(
                errorMessage: 'Failed to fetch word details',
              ),
            ),
          ),
        );
      },
    );
  }
}
