import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_youtube_bloc/models/video.dart';
import 'package:rxdart/rxdart.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains('favorites')) {
        _favorites = json.decode(prefs.getString("favorites")!).map((k, v) {
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();

        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
      _saveFav();
    } else {
      _favorites[video.id] = video;
    }

    _favController.sink.add(_favorites);
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', json.encode(_favorites));
    });
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
