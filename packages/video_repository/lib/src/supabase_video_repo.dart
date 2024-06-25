import 'dart:developer';
import 'package:pizza_repository/video_repository.dart';
import 'package:pizza_repository/src/video_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FirebaseVideoRepo implements VideoRepo{

  final supabase = Supabase.instance.client;

  Future<List<Video>> getVideos() async {
    try{
      final response = await supabase
          .from('Videos')
          .select('*, Users(*)');

      log(response.toString());

      if (response== null) {
        log("No data");
        return [];
      }

      return response.map((e) =>
          Video.fromEntity(VideoEntity.fromDocument(e))
      ).toList();
    }
    catch(e) {
      log(e.toString());
      rethrow;
    }
  }
}