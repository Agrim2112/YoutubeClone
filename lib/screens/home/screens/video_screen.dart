import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:pizza_repository/video_repository.dart';

class VideoScreen extends StatefulWidget {
  Video videos;
  VideoScreen(this.videos, {super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _controller;
  bool showIcons = false;
  bool isPlaying = true;
  Duration currentPosition = const Duration(seconds: 0);
  double currentSpeed = 1.0;
  bool isEnded = false;

  @override
  void initState() {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.videos.videoUrl))
          ..initialize().then((_) => {setState(() {})});
    _controller?.play();
    _controller?.addListener(() {
      setState(() {
        currentPosition = _controller!.value.position;
      });
      if(!_controller!.value.isPlaying && _controller!.value.position >= _controller!.value.duration){
        setState(() {
          isEnded=true;
        });
        print('Video ended');
      }
      print(isEnded);
      print('Current position: ${_controller!.value.position}'); // Add this line
      print('Duration: ${_controller!.value.duration}'); // Add this line
    });
    super.initState();
  }

  toggleVideoPlayer() {
    isPlaying ? _controller?.play() : _controller?.pause();
  }

  forwardVideo() {
    final Duration newPosition =
        _controller!.value.position + const Duration(seconds: 5);
    _controller!.seekTo(newPosition);
  }

  backVideo() {
    final Duration newPosition =
        _controller!.value.position - const Duration(seconds: 5);
    _controller!.seekTo(newPosition);
  }


  replayVideo() {
    _controller!.seekTo(Duration(seconds: 0));
    setState(() {
      isEnded=false;
    });
    _controller?.play();
  }

  void changePlaybackSpeed(double speed) {
    setState(() {
      currentSpeed = speed;
    });
    _controller?.setPlaybackSpeed(speed);
  }

  String formatDuration(int durationInSeconds) {
    final Duration duration = Duration(seconds: durationInSeconds);
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    if (hours >= 1) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  String formatViews(int views) {
    if(views>=1000000000){
      double result=views/1000000000;
      if (views % 1000000000 == 0) {
        return '${result.round()}B';
      } else {
        return '${result.toStringAsFixed(1)}B';
      }
    }
    else if(views>=1000000){
      double result=views/1000000;
      if (views % 1000000 == 0) {
        return '${result.round()}M';
      } else {
        return '${result.toStringAsFixed(1)}M';
      }
    }
    else if(views>=1000){
      return '${views/1000}K';
    }
    else {
      return views.toString();
    }
  }

  String formatUploadDate(String uploadDate) {
    DateTime uploadDateTime = DateFormat('dd-MM-yyyy').parse(uploadDate);
    Duration difference = DateTime.now().difference(uploadDateTime);

    if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inDays==1 ? 'hour ago' : 'hours ago'}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays==1 ? 'day ago' : 'days ago'}';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).round()} ${(difference.inDays / 7).round()==1? 'week ago' : 'weeks ago'}';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).round()} ${(difference.inDays / 30).round()==1? 'month ago' : 'months ago'}';
    } else {
      return '${(difference.inDays / 365).round()} ${(difference.inDays / 365).round()==1? 'year ago' : 'years ago'}';
    }
  }

  void showSettingsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black.withOpacity(0.9),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: currentSpeed == 0.25 ? Icon(Icons.check, color: Colors.white,) : null,
                title: Text(
                  '0.25x',
                  style: TextStyle(
                    color: Colors.grey.shade100
                  ),
                ),
                onTap: () {
                  changePlaybackSpeed(0.25);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: currentSpeed == 0.5 ? Icon(Icons.check) : null,
                title: Text('0.5x',
                    style: TextStyle(
                    color: Colors.grey.shade100
                    )
                ),
                onTap: () {
                  changePlaybackSpeed(0.5);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: currentSpeed == 0.75 ? Icon(Icons.check) : null,
                title: Text(
                    '0.75x',
                    style: TextStyle(
                        color: Colors.grey.shade100
                    )
                ),
                onTap: () {
                  changePlaybackSpeed(0.75);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: currentSpeed == 1.0 ? Icon(Icons.check) : null,
                title: Text(
                    '1.0x',
                    style: TextStyle(
                        color: Colors.grey.shade100
                    )
                ),
                onTap: () {
                  changePlaybackSpeed(1.0);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: currentSpeed == 1.25 ? Icon(Icons.check) : null,
                title: Text(
                    '1.25x',
                    style: TextStyle(
                        color: Colors.grey.shade100
                    )
                ),
                onTap: () {
                  changePlaybackSpeed(1.25);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: currentSpeed == 1.5 ? Icon(Icons.check) : null,
                title: Text(
                    '1.5x',
                    style: TextStyle(
                        color: Colors.grey.shade100
                    )
                ),
                onTap: () {
                  changePlaybackSpeed(1.5);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: currentSpeed == 1.75 ? Icon(Icons.check) : null,
                title: Text(
                    '1.75x',
                    style: TextStyle(
                        color: Colors.grey.shade100
                    )
                ),
                onTap: () {
                  changePlaybackSpeed(1.75);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: currentSpeed == 2.0 ? Icon(Icons.check) : null,
                title: Text(
                    '2.0x',
                    style: TextStyle(
                        color: Colors.grey.shade100
                    )
                ),
                onTap: () {
                  changePlaybackSpeed(2.0);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: _controller!.value.isInitialized
                ? Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showIcons = (!showIcons);
                            });
                            if (isPlaying && showIcons == true) {
                              Future.delayed(const Duration(seconds: 2), () {
                                if (mounted) {
                                  setState(() {
                                    showIcons = false;
                                  });
                                }
                              });
                            }
                          },
                          child: Stack(children: [
                            VideoPlayer(_controller!),
                            showIcons
                                ? Positioned(
                                    bottom: 12,
                                    left: 12,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            formatDuration(
                                                currentPosition.inSeconds),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Text(
                                            ' / ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            formatDuration(
                                                widget.videos.duration),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            Row(children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: GestureDetector(
                                  onDoubleTap: backVideo,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: GestureDetector(
                                    onDoubleTap: forwardVideo,
                                  ))
                            ]),
                            showIcons
                                ? SizedBox(
                                    height: _controller!.value.aspectRatio *
                                        (MediaQuery.sizeOf(context).width),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.black
                                                    .withOpacity(0.3)),
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
                                          icon: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.black
                                                    .withOpacity(0.3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                isEnded ? CupertinoIcons.arrow_counterclockwise
                                                :(isPlaying
                                                    ? CupertinoIcons.pause
                                                    : CupertinoIcons
                                                        .play_arrow_solid),
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            isEnded ? replayVideo()
                                            :setState(() {
                                              isPlaying = (!isPlaying);
                                            });
                                            if(!isEnded) {
                                              toggleVideoPlayer();
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.black
                                                    .withOpacity(0.3)),
                                            child: Padding(
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
                                : const SizedBox(),
                            showIcons?
                            Positioned(
                              top: 6,
                              right: 6,
                              child: IconButton(
                                icon: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      color: Colors.black
                                          .withOpacity(0.3)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.grey.shade100,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  showSettingsModal(context);
                                },
                              ),
                            ):const SizedBox(),
                          ]),
                        ),
                      ),
                      Container(
                        height: 2,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 0.5,
                            trackShape: CustomTrackShape(),
                            thumbShape:
                                showIcons // Check the visibility state of the thumb
                                    ? const RoundSliderThumbShape(
                                        enabledThumbRadius: 6.0)
                                    : const RoundSliderThumbShape(
                                        enabledThumbRadius: 0.0),
                            activeTrackColor: Colors.red,
                            inactiveTrackColor: Colors.grey.shade500,
                            thumbColor: Colors.red,
                            overlayColor: Colors.grey.shade500,
                          ),
                          child: Material(
                            child: Slider.adaptive(
                              min: 0,
                              max: _controller!.value.duration.inSeconds
                                  .toDouble(),
                              value: currentPosition.inSeconds.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  currentPosition =
                                      Duration(seconds: value.toInt());
                                  _controller!.seekTo(currentPosition);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          widget.videos.title,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade200,
                            height: 1.3
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Text(
                                '${formatViews(widget.videos.views)} views',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                formatUploadDate(widget.videos.uploadDate),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500,
                                ),
                              )
                            ],
                          ),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Image.asset('assets/avatar.png'),
                                      radius: 18,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      widget.videos.Users.name,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.grey.shade200
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '21 subscribers',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Colors.grey.shade500
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                    child: Text(
                                      'Subscribe',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
