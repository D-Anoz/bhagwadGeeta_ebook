import 'package:ebook/core/constants/images.dart';
import 'package:ebook/presentation/bloc/splash/splash_bloc.dart';
import 'package:ebook/presentation/screens/home/home.dart';
import 'package:ebook/presentation/screens/onbaording/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

bool? isOnboardingDone = false;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getValue();
    print(isOnboardingDone);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is LoadedState) {
            print('FRM LOADED, we are at: ${state.toString()}');
            // isOnboardingDone ? Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())) : Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreenOne()));

            if (isOnboardingDone != null && isOnboardingDone!) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OnboardingScreenOne()));
            }
          }
        },
        child: Center(
          child: Image.asset(Images.splash),
        ));
  }

  void getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnboardingFinished = prefs.getBool('isOnboardingFinished') ?? false;
    print('this is prefs:$isOnboardingFinished');
    isOnboardingDone = isOnboardingFinished;
  }
}
