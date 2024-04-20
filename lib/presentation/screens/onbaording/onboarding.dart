import 'package:ebook/core/constants/colors.dart';
import 'package:ebook/core/constants/images.dart';
import 'package:ebook/presentation/common_widgets/onboarding.dart';
import 'package:ebook/presentation/screens/home/home.dart';
import 'package:ebook/presentation/screens/onbaording/onboarding_items.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({super.key});

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  final obItems = OnbordingItems();

  final pageController = PageController();
  bool isEndPage = false;
  String selectedLang = 'eng';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obBgColor,
      body: PageView.builder(
          itemCount: obItems.items.length,
          controller: pageController,
          onPageChanged: (index) => setState(() => isEndPage = obItems.items.length - 1 == index),
          itemBuilder: (context, index) {
            return CustomOnboardingWidget(
              image: obItems.items[index]['img'],
              title: obItems.items[index]['title'],
              desc: obItems.items[index]['desc'],
            );
          }),
      bottomSheet: Container(
        color: AppColors.obBgColor,
        child: isEndPage
            ? getStarted()
            : Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        pageController.jumpToPage(obItems.items.length - 1);
                      },
                      child: const Text('SKIP', style: TextStyle(fontSize: 17, color: AppColors.obText)),
                    ),

                    //indicator

                    SmoothPageIndicator(
                      controller: pageController,
                      count: obItems.items.length,
                      onDotClicked: (index) => pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
                      effect: WormEffect(dotHeight: 10, dotWidth: 10, activeDotColor: AppColors.smoothPageScrollActiveDot, dotColor: AppColors.smoothPageScrollDisableDot),
                    ),

                    //next button
                    GestureDetector(
                      onTap: () {
                        pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                      },
                      child: const Row(
                        children: [
                          Text(
                            'NEXT',
                            style: TextStyle(fontSize: 17, color: AppColors.obText),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: AppColors.obText,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget getStarted() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: AppColors.buttonColor),
              width: 123,
              height: 40,
              child: TextButton(
                  onPressed: () async {
                    // SharedPreferenceHelper().setOnboardingComplete(true);
                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                    // prefs.setBool('isOnboardingFinished', true);
                    preferedLang();
                    // ignore: use_build_context_synchronously
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16, color: AppColors.obText),
                  ))),
        ],
      ),
    );
  }

  void preferedLang() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero, //removes the padding inside the alertDialog
              content: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.alertDialog,
                  ),
                  child: Stack(children: [
                    Column(
                      children: [
                        Image.asset(
                          Images.topRect,
                          height: 100,
                          width: 100,
                        ),
                        Image.asset(
                          Images.lang,
                          height: 100,
                          width: 100,
                        ),
                        const Text(
                          'Choose your preferred language',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '(Don’t worry you can change it later)',
                          style: TextStyle(fontSize: 12, color: Color(0xff3C3C3C)),
                        ),
                        //radio button
                        ListTile(
                          title: Text('English'),
                          leading: Radio(
                            value: 'eng',
                            groupValue: selectedLang,
                            onChanged: (value) {
                              setState(() {
                                selectedLang = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Hindi'),
                          leading: Radio(
                            value: 'eng',
                            groupValue: selectedLang,
                            onChanged: (value) {
                              setState(() {
                                selectedLang = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: AppColors.buttonColor),
                            width: 163,
                            height: 40,
                            child: TextButton(
                                onPressed: () async {
                                  // SharedPreferenceHelper().setOnboardingComplete(true);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('isOnboardingFinished', true);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Ok, Let\'s go',
                                      style: TextStyle(fontSize: 16, color: AppColors.obText),
                                    ),
                                    Icon(Icons.arrow_forward, color: AppColors.obText),
                                  ],
                                ))),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            Images.bottRect,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ));
  }
}
