import 'package:bloc/bloc.dart';
import 'package:ebook/presentation/bloc/selected%20chapter/selected_chapter_event.dart';
import 'package:ebook/presentation/bloc/selected%20chapter/selected_chapter_state.dart';

import '../../../data/data_sources/remote/chapter_data.dart';
import '../../../data/models/individual_chapter_model.dart';

class SelectedChapterBloc extends Bloc<SelectedChapterEvent, SelectedChapterState> {
  final selectedChapterRepo selChapRepo = selectedChapterRepo();
  SelectedChapterBloc() : super(InitialState()) {
    on<SelectedChapterEvent>((event, emit) async {
      if (event is ChapterFetchedEvent) {
        try {
          emit(LoadingState());
          final selChapterData = await selChapRepo.getSelChapters();
          print('Length from the SelectedChapterBloc: ${selChapterData.length}');
          print('Data from the SelectedChapterBloc: ${selChapterData.isEmpty}');
          emit(LoadedState(selChaptersData: selChapterData.cast<IndividualSelectedChapterModel>()));
        } catch (ex) {
          emit(LoadingErrorState(errorMsg: ex.toString()));
        }
      }
    });
  }
}
