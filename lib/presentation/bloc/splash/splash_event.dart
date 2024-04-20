import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStartedEvent extends SplashEvent {}
