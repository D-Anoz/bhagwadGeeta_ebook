import 'package:ebook/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/individual_verse_model.dart';
import '../../bloc/individual verse/bloc/individual_verse_bloc.dart';

class IndividualVerseScreen extends StatefulWidget {
  const IndividualVerseScreen({super.key});

  @override
  State<IndividualVerseScreen> createState() => _IndividualVerseScreenState();
}

class _IndividualVerseScreenState extends State<IndividualVerseScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   VerseRepo repo = VerseRepo();
  //   repo.getIndividualVerse();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verse detail',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => IndividualVerseBloc()..add(IndividualVerseFetched()),
        child: BlocConsumer<IndividualVerseBloc, IndividualVerseState>(
            builder: (context, state) {
              if (state is IndividualVerseLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Please wait..')
                    ],
                  ),
                );
              } else if (state is IndividualVerseLoaded) {
                List<Commentary> translationData = state.translations;
                List<Commentary> commentaryData = state.commentary;

                String text = state.text;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          '1.1',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: AppColors.buttonColor),
                          ),
                        ),
                        ListView.builder(
                            itemCount: translationData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: Text(
                                          'Translation',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        translationData[index].description ?? 'No description',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        translationData[index].authorName ?? 'Unknown author',
                                        style: TextStyle(color: AppColors.buttonColor, fontSize: 17, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  )
                                ],
                              );
                            }),
                        const Divider(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //for commentaries
                        ListView.builder(
                            itemCount: commentaryData.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: Text(
                                          'commentaryData',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        commentaryData[index].description ?? 'No description',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        commentaryData[index].authorName ?? 'Unknown author',
                                        style: TextStyle(color: AppColors.buttonColor, fontSize: 17, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  )
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                );
              } else if (state is IndividualVerseLoadingError) {
                print(state.errorMsg);
              }
              return Container();
            },
            listener: (context, state) {}),
      ),
    );
  }
}
