part of 'words_bloc.dart';

@freezed
class WordsEvent with _$WordsEvent {
  const factory WordsEvent.fetchUserWords() = _FetchUserWords;
}
