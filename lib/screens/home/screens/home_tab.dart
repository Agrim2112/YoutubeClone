import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubeclone/screens/home/bloc/get_videos_bloc/get_video_bloc.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  String formatDuration(int durationInSeconds) {
    final Duration duration = Duration(seconds: durationInSeconds);
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    if(hours>=1)
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    else
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<GetVideoBloc,GetVideoState>(
        builder: (context,state){
          if(state is GetVideoSuccess) {
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {

                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                            Image.network(
                            state.videos[index].thumbnail,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: (9 * MediaQuery
                                .of(context)
                                .size
                                .width) / 16,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            bottom: 6,
                            right: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal:4),
                                child: Text(
                                  formatDuration(state.videos[index].duration),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          const Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/avatar.png'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.videos[index].title,
                                  style: const TextStyle(
                                      height: 1.3,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                        state.videos[index].Users.name,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        )
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '${formatViews(state.videos[index].views)} views',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                        formatUploadDate(state.videos[index].uploadDate),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.grey.shade300,
                                size: 25,
                              )
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 24)
                    ],
                  ),
                );
              },
            );
          }
          else if(state is GetVideoLoading){
            return const CircularProgressIndicator();
          }
          else{
            return const Center(
              child: Text(
                "An error occurred, please try again.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            );
          }
        }
      ),
    );
  }
}

