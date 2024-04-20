import 'package:equatable/equatable.dart';

abstract class SelectedChapterEvent extends Equatable {
  const SelectedChapterEvent();

  @override
  List<Object> get props => [];
}

class ChapterFetchedEvent extends SelectedChapterEvent {}
