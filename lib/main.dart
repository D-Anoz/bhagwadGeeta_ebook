import 'package:ebook/core/constants/colors.dart';
import 'package:ebook/presentation/bloc/home/home_bloc.dart';
import 'package:ebook/presentation/bloc/splash/splash_bloc.dart';
import 'package:ebook/presentation/bloc/verses/bloc/verses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/individual verse/bloc/individual_verse_bloc.dart';
import 'presentation/bloc/selected chapter/selected_chapter_bloc.dart';
import 'presentation/screens/splash/splash.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
      BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
      BlocProvider<VersesBloc>(create: (context) => VersesBloc()),
      BlocProvider<SelectedChapterBloc>(create: (context) => SelectedChapterBloc()),
      BlocProvider<IndividualVerseBloc>(create: (context) => IndividualVerseBloc()),
    ],
    child: MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: AppColors.appBarColor,
          ),
          textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white))),
      home: const SplashScreen(),
    ),
  ));
}
