part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeLoadedEvent extends HomeEvent {}

class VerseSelectedEvent extends HomeEvent {
  final int chapterId;

  VerseSelectedEvent(this.chapterId);

  @override
  List<Object> get props => [chapterId];
}
