import '../entities/entities.dart';
import '../entities/video_entity.dart';
import 'package:user_repository/user_repository.dart';

class Video {
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

  Video({
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

  VideoEntity toEntity() {
    return VideoEntity(
        videoId:videoId,
        title: title,
        uploadDate: uploadDate,
        thumbnail: thumbnail,
        videoUrl: videoUrl,
        like:like,
        dislike:dislike,
        userId:userId,
        duration:duration,
        Users:Users,
        views:views
    );
  }

  static Video fromEntity(VideoEntity entity) {
    return Video(
        videoId:entity.videoId,
        title: entity.title,
        uploadDate: entity.uploadDate,
        thumbnail: entity.thumbnail,
        videoUrl: entity.videoUrl,
        like: entity.like,
        dislike:entity.dislike,
        userId:entity.userId,
        duration:entity.duration,
        Users:entity.Users,
        views: entity.views
    );
  }

}