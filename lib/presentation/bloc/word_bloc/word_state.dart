part of 'word_bloc.dart';

@freezed
class WordState with _$WordState {
  const factory WordState.initial() = Initial;
  const factory WordState.loading() = Loading;
  const factory WordState.error() = Error;
  const factory WordState.success(List<String> definitions, String? audioUrl) =
      Success;
}
