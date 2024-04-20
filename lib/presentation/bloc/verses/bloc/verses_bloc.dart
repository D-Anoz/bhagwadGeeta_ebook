import 'package:bloc/bloc.dart';
import 'package:ebook/data/data_sources/remote/verse_data.dart';

import 'verses_event.dart';
import 'verses_state.dart';

class VersesBloc extends Bloc<VerseEvent, VerseState> {
  final VerseRepo repo = VerseRepo();
  VersesBloc() : super(VerseInitalState()) {
    on<VerseEvent>((event, emit) async {
      if (event is VerseFetchedEvent) {
        try {
          emit(VerseLoadingState());
          final verseData = await repo.getVerse(event.verseID);
          print('Verse id from the Verse bloc: ${event.verseID}');
          final selChapterData = await repo.getSelChapter();
          emit(VerseLoadedState(
            verseList: verseData,
            selChapter: selChapterData,
          ));
        } catch (ex) {
          emit(VerseLoadingFailedState(errorMsg: ex.toString()));
        }
        // } else if (event is ChapterSelectedEvent) {
        //   print(event.verId);

        //   emit(VerseSelectedForChapterState(selectedIndex: event.verId));
        // }
      }
    });
  }
}



//selectedIndex: event.verseID