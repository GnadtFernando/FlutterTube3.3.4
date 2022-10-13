import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorite_youtube_bloc/blocs/videos_bloc.dart';
import 'package:favorite_youtube_bloc/delegates/data_search.dart';
import 'package:favorite_youtube_bloc/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('images/yt_logo_rgb_dark.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return VideoTile(
                    video: snapshot.data[index],
                  );
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
