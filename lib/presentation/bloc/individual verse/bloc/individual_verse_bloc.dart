import 'package:bloc/bloc.dart';
import 'package:ebook/data/data_sources/remote/verse_data.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/individual_verse_model.dart';

part 'individual_verse_event.dart';
part 'individual_verse_state.dart';

class IndividualVerseBloc extends Bloc<IndividualVerseEvent, IndividualVerseState> {
  final VerseRepo repo = VerseRepo();
  IndividualVerseBloc() : super(IndividualVerseInitial()) {
    on<IndividualVerseFetched>((event, emit) async {
      emit(IndividualVerseLoading());
      try {
        final verse = await repo.getIndividualVerse();
        print(verse.translations);
        emit(
          IndividualVerseLoaded(
            translations: verse.translations ?? [],
            commentary: verse.commentaries ?? [],
            text: verse.text ?? 'No name',
          ),
        );
      } catch (e) {
        rethrow;
      }
    });
  }
}
