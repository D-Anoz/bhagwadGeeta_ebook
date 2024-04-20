import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/selected chapter/selected_chapter_bloc.dart';
import '../../bloc/selected chapter/selected_chapter_event.dart';
import '../../bloc/selected chapter/selected_chapter_state.dart';

class SelectedChapterScreen extends StatefulWidget {
  const SelectedChapterScreen({super.key});

  @override
  State<SelectedChapterScreen> createState() => _SelectedChapterScreenState();
}

class _SelectedChapterScreenState extends State<SelectedChapterScreen> {
  SelectedChapterBloc cBloc = SelectedChapterBloc();

  @override
  void initState() {
    cBloc.add(ChapterFetchedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.abc, color: Colors.black),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu_rounded, color: Colors.black),
              ),
            ],
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => cBloc,
        child: BlocConsumer<SelectedChapterBloc, SelectedChapterState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is LoadedState) {
              final selChapters = state.selChaptersData;
              if (selChapters.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: selChapters.length,
                          itemBuilder: (context, index) {
                            final selChapData = selChapters[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(selChapData.id.toString()),
                              ),
                              title: Text(selChapData.text ?? 'No data'),
                              subtitle: Text(selChapData.translations![0].description ?? 'Bitch there is no data.'),
                            );
                          }),
                    )
                  ],
                );
              } else {
                print(selChapters.length);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'There is no data at all because the length of selChapter is absolute ${selChapters.length} 😛',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                );
              }
            } else if (state is LoadingErrorState) {
              print(state.errorMsg);
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    state.errorMsg,
                    style: const TextStyle(fontSize: 23),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('Nothig is here'),
              );
            }
          },
        ),
      ),
    );
  }
}
