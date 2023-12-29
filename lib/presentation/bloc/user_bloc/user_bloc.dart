import 'package:bloc/bloc.dart';
import 'package:englishlearning_app/data/repository/auth_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;

  UserBloc({required this.authRepository}) : super(const UserState.initial()) {
    on<_SignInEvent>((event, emit) async {
      emit(const UserState.loading());
      try {
        await authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(const UserState.success());
      } catch (e) {
        emit(const UserState.error());
      }
    });

    on<_SignUpEvent>((event, emit) async {
      emit(const UserState.loading());
      try {
        await authRepository.signUp(
          email: event.email,
          password: event.password,
          name: event.name,
        );
        emit(const UserState.success());
      } catch (e) {
        emit(const UserState.error());
      }
    });

    on<_SignOutEvent>((event, emit) async {
      await authRepository.logout();
      emit(const UserState.initial());
    });
  }
}
