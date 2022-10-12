import 'package:favorite_youtube_bloc/delegates/data_search.dart';
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
              print(result);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
