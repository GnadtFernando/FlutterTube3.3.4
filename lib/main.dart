import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_youtube_bloc/api.dart';
import 'package:favorite_youtube_bloc/blocs/videos_bloc.dart';
import 'package:favorite_youtube_bloc/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  Api api = Api();
  api.search('eletro');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc(
          (i) => VideosBloc(),
        ),
      ],
      dependencies: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const Home(),
      ),
    );
  }
}
