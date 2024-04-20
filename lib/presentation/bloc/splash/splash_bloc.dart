import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ebook/presentation/bloc/splash/splash_event.dart';
import 'package:ebook/presentation/bloc/splash/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialState()) {
    on<SplashEvent>((event, emit) async {
      if (event is AppStartedEvent) {
        emit(LoadingState());
        await Future.delayed(const Duration(seconds: 3));
        emit(LoadedState());
      }
    });
  }
}
