import 'dart:convert';

import 'package:flutter_application_1/model/home/get_favorite.dart';
import 'package:http/http.dart' as http;

import '../model/home/get_all_song.dart';

class HomeService{


  Future<List<GetAllSong>> getAllSong() async {
    final response = await http.get(Uri.parse('http://192.168.100.11/get/songs/all'));

    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => GetAllSong.fromJson(data)).toList();
    }else{
      throw Exception('Fail to load to server');
    }

  }

  Future<List<GetFavorite>> getFavorite() async {
    final response = await http.get(Uri.parse('http://192.168.100.11/get/popularSongs'));
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => GetFavorite.fromJson(data)).toList();
    }else{
      throw Exception('Fail to load to server');
    }
  }

}