import 'package:bloc/bloc.dart';
import 'package:ebook/data/data_sources/remote/home_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ebook/data/models/chapter_model.dart';

part 'home_event.dart';
part 'home_state.dart';

//! Use part and part of in other blocs in similar way. Doing so we need to import only one bloc file while using event or states.

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
