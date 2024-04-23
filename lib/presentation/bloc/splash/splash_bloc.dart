import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'splash_event.dart';
part 'splash_state.dart';

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
