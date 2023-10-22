import 'package:englishlearning_app/presentation/bloc/word_bloc/word_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordScreen extends StatelessWidget {
  final String word;

  const WordScreen({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Details'),
      ),
      body: BlocBuilder<WordBloc, WordState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox(),
            success: (definitions, audioUrl) {
              return Card(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(word.toUpperCase()),
                    const SizedBox(height: 10),
                    Text(definitions.join(', ')),
                    const SizedBox(height: 10),
                    if (audioUrl != null)
                      TextButton(
                        onPressed: () {
                          // Play the audio using the audio URL
                        },
                        child: const Text('Pronunciation'),
                      ),
                  ],
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: () => const Text('Failed to fetch word details.'),
          );
        },
      ),
    );
  }
}
