import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/bloc.dart';
import '../model/Images_model.dart';

class ApiProvider {
  final String _url =
      'https://api.unsplash.com/photos?per_page=30&client_id=zrrTzstX7x6ivPUscO_T8FxAUEFfpPBnVFLfbwBl3dI';

  fetchImagesList() async {
    var s = Uri.parse(_url);
    var imagesList = [];
    var client = http.Client();

    try {
      var response = await client.get(s);
      imagesList = List.from(jsonDecode(response.body))
          .map((e) => ImagesModel.fromMap(e))
          .toList();
      return imagesList;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Future.error("Server not available !");
    }
  }

  SearchImages(qry) async {
    final _url =
        'https://api.unsplash.com/search/photos?page=1&query=$qry&client_id=zrrTzstX7x6ivPUscO_T8FxAUEFfpPBnVFLfbwBl3dI';
    var s = Uri.parse(_url);
    var imagesList = [];
    var client = http.Client();

    try {
      var response = await client.get(s);
      imagesList = List.from(jsonDecode(response.body)['results'])
          .map((e) => ImagesModel.fromMap(e))
          .toList();
      return imagesList;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Future.error("Server not available !");
    }
  }

  FavImages() async {
    var images = [];
    var client = http.Client();
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    List<String> array = prefs.getStringList('fav') ?? [];
    for (var i = 0; i < array.length; i++) {
      final baseUrl =
          'https://api.unsplash.com/photos/${array[i]}?client_id=zrrTzstX7x6ivPUscO_T8FxAUEFfpPBnVFLfbwBl3dI';
      final url = Uri.parse(baseUrl);
      try {
        final response = await http.get(url);
        var image = jsonDecode(response.body);
        images.add(image);
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return Future.error("Server not available !");
      }
    }
    return List.from(images).map((e) => ImagesModel.fromMap(e)).toList();
  }

  DownloaddedImages() async {
    var images = [];
    var client = http.Client();
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    List<String> array = prefs.getStringList('downloaded') ?? [];
    for (var i = 0; i < array.length; i++) {
      final baseUrl =
          'https://api.unsplash.com/photos/${array[i]}?client_id=zrrTzstX7x6ivPUscO_T8FxAUEFfpPBnVFLfbwBl3dI';
      final url = Uri.parse(baseUrl);
      try {
        final response = await http.get(url);
        var image = jsonDecode(response.body);
        images.add(image);
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return Future.error("Server not available !");
      }
    }
    return List.from(images).map((e) => ImagesModel.fromMap(e)).toList();
  }
}
