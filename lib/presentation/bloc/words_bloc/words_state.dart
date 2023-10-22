part of 'words_bloc.dart';

@freezed
class WordsState with _$WordsState {
  const factory WordsState.initial() = Initial;
  const factory WordsState.loading() = Loading;
  const factory WordsState.error() = Error;
  const factory WordsState.success(List<String> words) = Success;
}
