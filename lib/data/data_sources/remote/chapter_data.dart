// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/api.dart';
import '../../../core/services/api_services.dart';
import '../../models/individual_chapter_model.dart';

class selectedChapterRepo {
  Future<List<Object>> getSelChapters() async {
    List<IndividualSelectedChapterModel> selChapters = [];
    final connectivityResult = await ApiService.checkInternetConnection();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        //! Create a base Url to be used everywhere and a String file to denote endpoints.
        //* You can call [HttpService] from here.
        final response = await http.get(
            (Uri.parse(
                'https://bhagavad-gita3.p.rapidapi.com/v2/chapters/1/verses/1/')),
            headers: ApiHeader().header);
        if (response.statusCode == 200) {
          final Map<String, dynamic> result =
              json.decode(utf8.decode(response.bodyBytes));

          if (result.containsKey('translations')) {
            final List<dynamic> chapterList = result['translations'];
            final selChapters = chapterList
                .map<IndividualSelectedChapterModel>(
                    (json) => IndividualSelectedChapterModel.fromJson(json))
                .toList();

            print(selChapters.length);
            print(selChapters); // Print the entire list for further inspection
            return selChapters;
          } else {
            print('Error: The "data" key is missing in the response.');
            throw Exception('Data key is missing in the response');
            // Handle the case where the expected key is not present in the response
          }
          // final List<dynamic> chapterList = result['data'] ?? [];
          // selChapters = chapterList.map<IndividualSelectedChapterModel>((json) => IndividualSelectedChapterModel.fromJson(json)).toList();
          // // print(selChapters[1].text);
          // print('This is a response from the API: ${response.body}');
          // if (selChapters.isNotEmpty) {
          //   print(selChapters[0].text); // Accessing the first element in the list
          // } else {
          //   print('The list is empty.');
          // }
          // return selChapters;
        } else {
          print('Status code: ${response.statusCode}');
          throw Exception('Exception occured: ${response.body}');
        }
      } catch (ex) {
        rethrow;
      }
    } else {
      debugPrint('No internet');
      Fluttertoast.showToast(
          msg: 'Failed fetching data,no internet found.',
          timeInSecForIosWeb: 90,
          toastLength: Toast.LENGTH_LONG);
      return [];
    }
  }
}


//!
//!
//!
//!
//!
/*
Bloc---> Repository ---> Remote source 
Calls should in this if Clean code architecture is to be followed.
The current logic used in the repository should be in remote source
Repo will either call remote source or local source based on  the current online status then.
*/
//!
//!
//!
//!

