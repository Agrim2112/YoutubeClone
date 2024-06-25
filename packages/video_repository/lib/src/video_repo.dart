import '../video_repository.dart';

abstract class VideoRepo {

  Future<List<Video>> getVideos();
}