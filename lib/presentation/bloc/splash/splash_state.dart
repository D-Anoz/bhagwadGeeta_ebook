import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SplashState {}

class LoadingState extends SplashState {}

class LoadedState extends SplashState {}
