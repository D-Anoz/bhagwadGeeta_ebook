import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/selChapter.dart';
import '../../../../data/models/vmodel.dart';

@immutable
abstract class VerseState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerseInitalState extends VerseState {}

class VerseLoadingState extends VerseState {}

class VerseLoadedState extends VerseState {
  final List<VModel> verseList;
  final List<SelectedChapterModel> selChapter;

  VerseLoadedState({required this.verseList, required this.selChapter});

  @override
  List<Object> get props => [
        verseList,
        selChapter,
      ];
}

class VerseLoadingFailedState extends VerseState {
  final String errorMsg;

  VerseLoadingFailedState({required this.errorMsg});
  @override
  List<Object> get props => [
        errorMsg
      ];
}

//this is for the selected Chapters
// class VerseSelectedForChapterState extends VerseState {
//   final String selectedIndex;

//   VerseSelectedForChapterState({required this.selectedIndex});
//   @override
//   List<Object> get props => [
//         selectedIndex
//       ];
// }
