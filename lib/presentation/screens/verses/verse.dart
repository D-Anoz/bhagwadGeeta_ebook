import 'package:ebook/core/constants/colors.dart';
import 'package:ebook/core/constants/images.dart';
import 'package:ebook/presentation/bloc/verses/bloc/verses_bloc.dart';
import 'package:ebook/presentation/screens/indiv_verse/individual_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/verses/bloc/verses_event.dart';
import '../../bloc/verses/bloc/verses_state.dart';

class VerseScreen extends StatefulWidget {
  final String verseId;
  const VerseScreen({super.key, required this.verseId});

  @override
  State<VerseScreen> createState() => _VerseScreenState();
}

class _VerseScreenState extends State<VerseScreen> {
  // VersesBloc vBloc = VersesBloc();

  // @override
  // void initState() {
  //   vBloc.add(VerseFetchedEvent(verseID: 1.toString()));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Verse',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Images.verseBg), fit: BoxFit.cover)),
        child: BlocProvider(
          create: (context) => VersesBloc()..add(VerseFetchedEvent(verseID: widget.verseId)),
          child: BlocConsumer<VersesBloc, VerseState>(listener: (context, state) {
            // if (state is VerseSelectedForChapterState) {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectedChapterScreen()));
            // }
          }, builder: (context, state) {
            if (state is VerseLoadingState) {
              print('Verse id got from the home screen: ${widget.verseId}');
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please wait...',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              );
            } else if (state is VerseLoadedState) {
              final verses = state.verseList;
              final selectedChapter = state.selChapter;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Images.chapter,
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Chapter ${selectedChapter[0].chapterNumber}',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(Images.chapter, height: 20, width: 20),
                                ],
                              ),
                              Text(selectedChapter[0].nameTranslated ?? 'No name'),
                              Text(
                                selectedChapter[0].chapterSummary ?? 'No description',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Flexible(
                      child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: verses.length,
                          itemBuilder: (context, index) {
                            final versesData = verses[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 0, bottom: 40),
                              child: GestureDetector(
                                onTap: () {
                                  print(versesData.id);
                                  print('bitch');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IndividualVerseScreen()));
                                  // vBloc.add(ChapterSelectedEvent(verId: versesData.id.toString()));
                                },
                                child: ListTile(
                                    title: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.menu_book_outlined, color: AppColors.buttonColor),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Verse: ${versesData.verseNumber.toString()}'),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.chevron_right,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Text(
                                          versesData.translations![4].description ?? 'no description',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Color.fromARGB(255, 187, 187, 187),
                                          indent: 20,
                                          endIndent: 20,
                                        )
                                      ],
                                    )),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('You shouldn\'t be here.'),
              );
            }
          }),
        ),
      ),
    );
  }
}
