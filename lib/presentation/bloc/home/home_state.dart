part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeIntialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<ChapterModel> chapList;

  HomeLoadedState({required this.chapList});
  @override
  List<Object> get props => [chapList];
}

class HomeLoadingErrorState extends HomeState {
  final String errorMsg;

  HomeLoadingErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class VerseSelectedState extends HomeState {
  final String selectedIndex;

  VerseSelectedState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
