// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:englishlearning_app/generated/l10n.dart';
import 'package:englishlearning_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:englishlearning_app/presentation/bloc/word_bloc/word_bloc.dart';
import 'package:englishlearning_app/presentation/bloc/words_bloc/words_bloc.dart';
import 'package:englishlearning_app/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:englishlearning_app/presentation/widgets/word_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> firebaseWords = [];
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    final wordsBloc = context.read<WordsBloc>();
    wordsBloc.add(const WordsEvent.fetchUserWords());
  }

  void _onSearchTextChanged() {
    final selectedWord = _searchController.text.trim().toLowerCase();
    final wordBloc = context.read<WordBloc>();

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 2), () {
      wordBloc.add(WordEvent.searchWord(word: selectedWord));

      if (!firebaseWords.any((word) => word.toLowerCase() == selectedWord)) {
        showModalBottomSheet(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (BuildContext context) {
            return WordBottomSheet(word: selectedWord);
          },
        );
      } else {
        setState(() {
          firebaseWords = [selectedWord];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myWords),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) {
                _onSearchTextChanged();
              },
              decoration: InputDecoration(
                hintText: S.of(context).searchWords,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          final wordsBloc = context.read<WordsBloc>();
                          wordsBloc.add(const WordsEvent.fetchUserWords());
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WordsBloc, WordsState>(
              builder: (context, state) {
                firebaseWords = state.maybeWhen(
                  orElse: () => const <String>[],
                  success: (words) => words,
                );
                return ListView.builder(
                  itemCount: firebaseWords.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(firebaseWords[index]),
                      onTap: () {
                        final selectedWord = firebaseWords[index].toLowerCase();
                        final wordBloc = context.read<WordBloc>();

                        wordBloc.add(
                          WordEvent.searchWord(word: selectedWord),
                        );

                        showModalBottomSheet(
                          clipBehavior: Clip.antiAlias,
                          context: context,
                          builder: (BuildContext context) {
                            return WordBottomSheet(
                              word: selectedWord,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          AppButton(
            text: S.of(context).signOut,
            onPressed: () {
              context.read<UserBloc>().add(const UserEvent.signOut());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
