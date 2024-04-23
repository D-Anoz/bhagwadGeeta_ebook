import 'dart:convert';

import 'package:connectivity_platform_interface/src/enums.dart';
import 'package:ebook/core/constants/api.dart';
import 'package:ebook/data/models/chapter_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/api_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeRepo {
  //checkInternetConnection connection=checkInternetConnection();
  Future<List<ChapterModel>> getChapter() async {
    List<ChapterModel> chapters = [];
    final connectivityResult = await ApiService.checkInternetConnection();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        //! Create a base Url to be used everywhere and a String file to denote endpoints.
        final response = await http.get(
            Uri.parse('https://bhagavad-gita3.p.rapidapi.com/v2/chapters/'),
            headers: ApiHeader().header);
        if (response.statusCode == 200) {
          print('success from ');
          final List<dynamic> result = json.decode(response.body);
          chapters = result
              .map<ChapterModel>((json) => ChapterModel.fromJson(json))
              .toList();
          return chapters;
        } else {
          print('Status code:${response.statusCode}');
          throw Exception('Exception occured: ${response.body}');
        }
      } catch (ex) {
        rethrow;
      }
    } else {
      print('No internet');
      Fluttertoast.showToast(
          msg: 'Failed fetching data,no internet found.',
          timeInSecForIosWeb: 90,
          toastLength: Toast.LENGTH_LONG);
      return [];
    }
  }
}
