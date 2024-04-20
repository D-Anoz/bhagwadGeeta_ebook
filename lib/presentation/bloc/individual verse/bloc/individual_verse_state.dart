part of 'individual_verse_bloc.dart';

class IndividualVerseState extends Equatable {
  const IndividualVerseState();

  @override
  List<Object> get props => [];
}

class IndividualVerseInitial extends IndividualVerseState {}

class IndividualVerseLoading extends IndividualVerseState {}

class IndividualVerseLoaded extends IndividualVerseState {
  final List<Commentary> translations;
  final List<Commentary> commentary;
  final String text;
  // final List<IndividualVerseModel> verseList;

  const IndividualVerseLoaded({required this.translations, required this.commentary, required this.text});

  @override
  List<Object> get props => [
        translations,
        commentary,
        // verseList
      ];
}

class IndividualVerseLoadingError extends IndividualVerseState {
  final String errorMsg;

  const IndividualVerseLoadingError({required this.errorMsg});

  @override
  List<Object> get props => [
        errorMsg
      ];
}
