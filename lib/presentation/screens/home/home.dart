import 'package:ebook/core/constants/colors.dart';
import 'package:ebook/core/constants/images.dart';
import 'package:ebook/presentation/bloc/home/home_bloc.dart';
import 'package:ebook/presentation/bloc/home/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_state.dart';
import '../verses/verse.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // HomeBloc hBloc = HomeBloc();

  // @override
  // void initState() {
  //   hBloc.add(HomeLoadedEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'BHAGAVAD GITA',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(HomeLoadedEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          // if (state is VerseSelectedState) {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => const VerseScreen()));
          // }

          // if(state is VerseSelectedEvent)
        }, builder: (context, state) {
          if (state is HomeIntialState) {
            return const Center(
              child: Text('wait for a while'),
            );
          } else if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is HomeLoadedState) {
            final chapters = state.chapList;
            return Column(
              children: [
                Stack(children: [
                  Image.asset(Images.listBgBlur),
                  Positioned(
                    bottom: 0,
                    left: 50,
                    child: Image.asset(
                      Images.listBg,
                      height: 160,
                    ),
                  ),
                ]),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Last read',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('VERSE 7.27'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('O Bharata, all beings are subject to delusion at birth due to the delusion of the pairs of opposites arising form desire and aversion, OParantapa'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'CONTINUE READING ',
                        style: TextStyle(color: AppColors.smoothPageScrollActiveDot),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        final chapIndex = chapters[index];
                        return BlocListener<HomeBloc, HomeState>(
                          listener: (context, state) {
                            if (state is VerseSelectedState) {}
                          },
                          child: GestureDetector(
                            onTap: () {
                              print('Verse id/index passed to the verse screen: ${chapIndex.id}');
                              // vBloc.getVerse(chapIndex.id.toString());
                              // hBloc.add(VerseSelectedEvent(chapIndex.id ?? 1));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerseScreen(
                                            verseId: chapIndex.id.toString(),
                                          )));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 29,
                                backgroundColor: AppColors.smoothPageScrollActiveDot,
                                child: Text(
                                  chapIndex.id.toString(),
                                  style: const TextStyle(color: AppColors.obText, fontSize: 16),
                                ),
                              ),
                              title: Text(chapIndex.nameTranslated ?? 'Untitled title'),
                              subtitle: Row(
                                children: [
                                  const Icon(Icons.list),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("${chapIndex.versesCount} verses")
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else if (state is HomeLoadingErrorState) {
            return Center(
              child: Text('Error: ${state.errorMsg}'),
            );
          } else {
            return const Center(child: Text('Something is wrong'));
          }
        }),
      ),
    );
  }
}
