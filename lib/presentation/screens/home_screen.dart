// ignore_for_file: library_private_types_in_public_api

import 'package:englishlearning_app/presentation/bloc/word_bloc/word_bloc.dart';
import 'package:englishlearning_app/presentation/bloc/words_bloc/words_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:englishlearning_app/presentation/screens/word_screen.dart';
import 'package:englishlearning_app/presentation/widgets/error_dialog.dart';
import 'package:englishlearning_app/presentation/widgets/loading_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final wordsBloc = context.read<WordsBloc>();
    wordsBloc.add(const WordsEvent.fetchUserWords());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Words'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search Words',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WordsBloc, WordsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox(),
                  success: (words) {
                    return ListView.builder(
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(words[index]),
                          onTap: () {
                            final selectedWord = words[index].toLowerCase();
                            final wordBloc = context.read<WordBloc>();
                            wordBloc
                                .add(WordEvent.searchWord(word: selectedWord));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WordScreen(word: selectedWord),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  loading: () => const LoadingDialog(),
                  error: () => const ErrorDialog(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
