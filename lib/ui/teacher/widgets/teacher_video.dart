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
  VideoPlayerController videoController = VideoPlayerController.network(
      'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4');

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      videoController = VideoPlayerController.network(widget.videoUrl!);
    }
    videoController.addListener(() {
      if (videoController.value.isInitialized) {
        setState(() {
          isLoadingVideo = false;
        });
      }
    });
    videoController.initialize();
  }

  onTapVideo() {
    if (!isPlayingVideo) {
      videoController.play();
    } else {
      videoController.pause();
    }
    setState(() {
      isPlayingVideo = !isPlayingVideo;
    });
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
                            child: VideoProgressIndicator(
                                colors: const VideoProgressColors(
                                    playedColor: Colors.blue),
                                videoController,
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
