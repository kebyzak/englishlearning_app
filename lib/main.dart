import 'package:englishlearning_app/data/repository/auth_repository.dart';
import 'package:englishlearning_app/firebase_options.dart';
import 'package:englishlearning_app/generated/l10n.dart';
import 'package:englishlearning_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:englishlearning_app/presentation/bloc/word_bloc/word_bloc.dart';
import 'package:englishlearning_app/presentation/bloc/words_bloc/words_bloc.dart';
import 'package:englishlearning_app/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<WordBloc>(
          create: (context) => WordBloc(),
        ),
        BlocProvider<WordsBloc>(
          create: (context) => WordsBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: AppRoutes.signInScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}
