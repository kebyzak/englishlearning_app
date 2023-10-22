// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'words_bloc.freezed.dart';
part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc() : super(const WordsState.initial()) {
    on<_FetchUserWords>((event, emit) async {
      emit(const WordsState.loading());
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userId = user.uid;

          final userWordsSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('words')
              .get();

          final userWords = userWordsSnapshot.docs
              .map((doc) => doc.data()['word'] as String)
              .toList();
          emit(WordsState.success(userWords));
        }
      } catch (e) {
        emit(const WordsState.error());
        emit(const WordsState.initial());
      }
    });
  }
}
