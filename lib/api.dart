import 'dart:convert';

import 'package:favorite_youtube_bloc/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyCu9eEvYdyQ6ZHHj3MbCHx9fIT0tL7Rosg";

class Api {
  search(String search) async {
    http.Response response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"),
    );

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else {
      throw Exception('Não deu pra carregar');
    }
  }
}

//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
