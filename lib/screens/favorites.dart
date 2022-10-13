import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:favorite_youtube_bloc/models/video.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Favoritos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        initialData: const {},
        stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.values.map((v) {
                return InkWell(
                  onLongPress: () {
                    BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(v);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                        child: Text(
                          v.title,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          } else {
            return const Center(
              child: Text(
                'Não foi possivel carregar dados',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
