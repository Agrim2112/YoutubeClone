import 'package:pizza_repository/video_repository.dart';
import 'package:user_repository/user_repository.dart';

class VideoEntity {
  String videoId;
  String title;
  String uploadDate;
  String thumbnail;
  String videoUrl;
  int like;
  int dislike;
  String userId;
  int duration;
  MyUser Users;
  int views;

  VideoEntity({
    required this.videoId,
    required this.title,
    required this.uploadDate,
    required this.thumbnail,
    required this.videoUrl,
    required this.like,
    required this.dislike,
    required this.userId,
    required this.duration,
    required this.Users,
    required this.views
  });


  Map<String,Object> toDocument(){
    return{
      'videoId': videoId,
      'title': title,
      'uploadDate':uploadDate,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'like': like,
      'dislike':dislike,
      'userId':userId,
      'duration':duration,
      'Users': Users.toEntity().toDocument(),
      'views': views
    };
  }

  static VideoEntity fromDocument(Map<String,dynamic> doc) {
    return VideoEntity(
        videoId:doc['videoId'],
        title: doc['title'],
        uploadDate: doc['uploadDate'],
        thumbnail: doc['thumbnail'],
        videoUrl: doc['videoUrl'],
        like: doc['like'],
        dislike:doc['dislike'],
        userId:doc['userId'],
        duration:doc['duration'],
        Users: MyUser.fromEntity(MyUserEntity.fromDocument(doc['Users'])),
        views: doc['views']
    );
    }
}