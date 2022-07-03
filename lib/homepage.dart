import 'dart:convert';

import 'package:assignment/Model/videoModel.dart';
import 'package:assignment/services/video.dart';

import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Image.asset(
              'assets/youtube.png',
              height: 50.0,
              width: 100.0,
            ),
          ),
          title: const Text(
            'Youtube',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.all(10.0),
              icon: Image.asset('assets/youtube_connect.png', height: 20),
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.all(10.0),
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.all(10.0),
              icon: Image.asset('assets/youtube_search.png'),
              onPressed: () {},
            ),
            InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/youtube_profile.png',
                    width: 30,
                  ),
                ))
          ],
        ),
        body: FutureBuilder<List<VideoModel>>(
            future: VideoServices.getVideos(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : InViewNotifierList(
                      isInViewPortCondition: (double deltaTop,
                          double deltaBottom, double viewPortDimension) {
                        return deltaTop < (0.5 * viewPortDimension) &&
                            deltaBottom > (0.5 * viewPortDimension);
                      },
                      itemCount: snapshot.data!.length,
                      builder: (BuildContext context, int index) {
                        return InViewNotifierWidget(
                          id: '$index',
                          builder: (BuildContext context, bool isInView,
                              Widget? child) {
                            return Card(
                              child: Column(
                                children: [
                                  Container(
                                      color: Colors.grey[900],
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: !isInView
                                          ? Image.network(
                                              snapshot.data![index].thumbnail)
                                          : Container()),
                                  Container(
                                    color: Colors.grey[900],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0,
                                              left: 15.0,
                                              bottom: 15.0),
                                          child: Text(
                                            snapshot.data![index].title,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
            }));
  }
}
