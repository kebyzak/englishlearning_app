part of 'word_bloc.dart';

@freezed
class WordEvent with _$WordEvent {
  const factory WordEvent.searchWord({required String word}) = _SearchWord;
}
