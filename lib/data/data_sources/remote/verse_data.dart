import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:ebook/core/constants/api.dart';
// import 'package:ebook/data/models/verse_model.dart';
import 'package:ebook/data/models/vmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/services/api_services.dart';
import 'package:http/http.dart' as http;

import '../../models/individual_verse_model.dart';
import '../../models/selChapter.dart';

class VerseRepo {
  Future<List<VModel>> getVerse(String id) async {
    print('this is ID from verseRepo:$id');
    List<VModel> verse = [];
    final connectivityResult = await ApiService.checkInternetConnection();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        //! Create a base Url to be used everywhere and a String file to denote endpoints.
        final response = await http.get(
            Uri.parse(
                'https://bhagavad-gita3.p.rapidapi.com/v2/chapters/$id/verses/'),
            headers: ApiHeader().header);
        if (response.statusCode == 200) {
          print('the id is:$id');
          final List<dynamic> result = json.decode(response.body);
          verse = result
              .map<VModel>(
                (json) => VModel.fromJson(json),
              )
              .toList();
          return verse;
        } else {
          print('Status code:${response.statusCode}');
          throw Exception('Exception occured: ${response.body}');
        }
      } catch (ex) {
        print('Exception is finally caught: ${ex.toString()}');
        rethrow;
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Failed fetching data,no internet found.',
          timeInSecForIosWeb: 90,
          toastLength: Toast.LENGTH_LONG);
      return [];
    }
  }

  //selected chapter's API call

  Future<List<SelectedChapterModel>> getSelChapter() async {
    List<SelectedChapterModel> selchapters = [];
    final connectivityResult = await ApiService.checkInternetConnection();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final response = await http.get(
            Uri.parse('https://bhagavad-gita3.p.rapidapi.com/v2/chapters/'),
            headers: ApiHeader().header);
        if (response.statusCode == 200) {
          print(response.statusCode);

          final List<dynamic> result = json.decode(response.body);
          selchapters = result
              .map<SelectedChapterModel>(
                (json) => SelectedChapterModel.fromJson(json),
              )
              .toList();
          return selchapters;
        } else {
          print('Status code:${response.statusCode}');
          throw Exception('Exception occured: ${response.body}');
        }
      } catch (ex) {
        print('Exception is finally caught: ${ex.toString()}');
        rethrow;
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Failed fetching data,no internet found.',
          timeInSecForIosWeb: 90,
          toastLength: Toast.LENGTH_LONG);
      return [];
    }
  }

// particular verse data

  Future<IndividualVerseModel> getIndividualVerse() async {
    final connectivityResult = await ApiService.checkInternetConnection();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final response = await http.get(
            Uri.parse(
                'https://bhagavad-gita3.p.rapidapi.com/v2/chapters/1/verses/1/'),
            headers: ApiHeader().header);
        if (response.statusCode != 200) {
          print(response.statusCode);
          throw Exception('Failed to load the data');
        }

        final parsedData = json.decode(utf8.decode(response
            .bodyBytes)); //uft8.decode is used to make the sys support the nepali font

        return IndividualVerseModel.fromJson(parsedData);
      } catch (ex) {
        print('Exception is finally caught: ${ex.toString()}');
        rethrow;
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Failed fetching data,no internet found.',
          timeInSecForIosWeb: 90,
          toastLength: Toast.LENGTH_LONG);
      throw Exception('No internet connection');
    }
  }
}
