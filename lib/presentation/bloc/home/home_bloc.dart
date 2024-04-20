import 'package:bloc/bloc.dart';
import 'package:ebook/data/data_sources/remote/home_data.dart';
import 'package:ebook/presentation/bloc/home/home_event.dart';
import 'package:ebook/presentation/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo repo = HomeRepo();
  HomeBloc() : super(HomeIntialState()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeLoadedEvent) {
        try {
          emit(HomeLoadingState());
          final chapData = await repo.getChapter();
          emit(HomeLoadedState(chapList: chapData));
        } catch (ex) {
          emit(HomeLoadingErrorState(errorMsg: ex.toString()));
        }
      } else if (event is VerseSelectedEvent) {
        // Pass the chapter ID to VerseSelectedState
        emit(VerseSelectedState(selectedIndex: event.chapterId.toString()));
      }
    });
  }
}
