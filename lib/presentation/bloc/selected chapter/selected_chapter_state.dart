import 'package:equatable/equatable.dart';

import '../../../data/models/individual_chapter_model.dart';

abstract class SelectedChapterState extends Equatable {
  const SelectedChapterState();

  @override
  List<Object> get props => [];
}

class InitialState extends SelectedChapterState {}

class LoadingState extends SelectedChapterState {}

class LoadedState extends SelectedChapterState {
  final List<IndividualSelectedChapterModel> selChaptersData;

  const LoadedState({required this.selChaptersData});

  @override
  List<Object> get props => [
        selChaptersData
      ];
}

class LoadingErrorState extends SelectedChapterState {
  final String errorMsg;

  const LoadingErrorState({required this.errorMsg});

  @override
  List<Object> get props => [
        errorMsg
      ];
}
