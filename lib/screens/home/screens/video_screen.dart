import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:pizza_repository/video_repository.dart';

class VideoScreen extends StatefulWidget {
  Video videos;
  VideoScreen(this.videos,{super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _controller;
  bool showIcons = false;
  bool isPlaying = true;

  @override void initState() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videos.videoUrl)
    )
    ..initialize().then((_) => {
      setState(() {})
    });
    _controller?.play();
    super.initState();
  }

  toggleVideoPlayer(){
    isPlaying ? _controller?.play() : _controller?.pause();
  }

  forwardVideo(){
    final Duration newPosition= _controller!.value.position + const Duration(seconds: 5);
    _controller!.seekTo(newPosition);
  }

  backVideo(){
    final Duration newPosition= _controller!.value.position - const Duration(seconds: 5);
    _controller!.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: _controller!.value.isInitialized? Column(
          children: [
            AspectRatio(
              aspectRatio:_controller!.value.aspectRatio,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    showIcons= (!showIcons);
                  });
                },
                child: Stack
                  (
                    children: [
                      VideoPlayer(_controller!),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: GestureDetector(
                              onDoubleTap: backVideo,
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: GestureDetector(
                                onDoubleTap: forwardVideo,
                            )
                          )
                        ]
                      ),
                      showIcons?
                          SizedBox(
                            height: _controller!.value.aspectRatio * (MediaQuery.sizeOf(context).width),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon:Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black.withOpacity(0.3)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        'assets/back.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    backVideo();
                                  },
                                ),
                                IconButton(
                                  icon:Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.black.withOpacity(0.3)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        isPlaying? CupertinoIcons.pause: CupertinoIcons.play_arrow_solid,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPlaying= (!isPlaying);
                                    });
                                    toggleVideoPlayer();
                                  },
                                ),
                                IconButton(
                                  icon:Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.black.withOpacity(0.3)
                                    ),
                                    child:  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        'assets/fast.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    forwardVideo();
                                  },
                                ),
                              ],
                            ),
                          )
                          :const SizedBox(),
                     ]
                  ),
              ),
            )
          ],
        )

            :const Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
