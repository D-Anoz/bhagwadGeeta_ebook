import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // void saveValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isOnboardingFinished', true);
  // }

  // Future<bool> getValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? isOnboardingFinished = prefs.getBool('isOnboardingFinished') ?? false;
  //   print('this is prefs:$isOnboardingFinished');
  //   return isOnboardingFinished;
  // }

  static const String onboardingCompleteKey = 'isOnBoardComplete';

  Future<bool> setOnboardingComplete(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    print(value);
    return prefs.setBool(onboardingCompleteKey, value);
  }

  Future<bool> getOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs);
    return prefs.getBool(onboardingCompleteKey) ?? false; // Default to false if not found
  }
}
