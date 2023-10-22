// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:englishlearning_app/data/repository/word_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_bloc.freezed.dart';
part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordRepository wordRepository = WordRepository();

  WordBloc() : super(const WordState.initial()) {
    on<_SearchWord>((event, emit) async {
      emit(const WordState.loading());
      try {
        final definitions = await wordRepository.fetchWord(event.word);
        final audioUrl = await wordRepository.fetchAudioUrl(event.word);

        emit(WordState.success(definitions, audioUrl));
      } catch (e) {
        emit(const WordState.error());
        emit(const WordState.initial());
      }
    });
  }
}
