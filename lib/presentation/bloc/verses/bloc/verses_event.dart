import 'package:equatable/equatable.dart';

abstract class VerseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VerseFetchedEvent extends VerseEvent {
  final String verseID;

  VerseFetchedEvent({required this.verseID});

  @override
  List<Object> get props => [
        verseID
      ];
}

class ChapterSelectedEvent extends VerseEvent {
  final String verId;

  ChapterSelectedEvent({required this.verId});

  @override
  List<Object> get props => [
        verId
      ];
}
