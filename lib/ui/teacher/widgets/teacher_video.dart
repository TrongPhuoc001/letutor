import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class TeacherVideo extends StatefulWidget {
  final String? videoUrl;
  const TeacherVideo({
    this.videoUrl,
    Key? key,
  }) : super(key: key);

  @override
  _TeacherVideoState createState() => _TeacherVideoState();
}

class _TeacherVideoState extends State<TeacherVideo> {
  bool isLoadingVideo = true;
  bool isPlayingVideo = false;
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(widget.videoUrl ?? '');

    videoController.initialize().then((value) {
      setState(() {
        isLoadingVideo = false;
      });
    });
  }

  onTapVideo() async {
    try {
      if (!videoController.value.isPlaying) {
        await videoController.play();
        print(1);
      } else {
        videoController.pause();
        print(2);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isPlayingVideo = !isPlayingVideo;
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.pause();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 2.0)),
      child: Center(
        child: !isLoadingVideo
            ? SizedBox(
                height: 250,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 220,
                        child: AspectRatio(
                            aspectRatio: videoController.value.aspectRatio,
                            child: VideoPlayer(videoController)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !isPlayingVideo
                            ? InkWell(
                                onTap: () {
                                  onTapVideo();
                                },
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 20,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  onTapVideo();
                                },
                                child: Icon(Icons.pause, size: 20)),
                        SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 20,
                            child: VideoProgressIndicator(videoController,
                                allowScrubbing: true),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                      ],
                    )
                  ],
                ))
            : SizedBox(
                height: 25,
                width: 25,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                )),
      ),
    );
  }
}
