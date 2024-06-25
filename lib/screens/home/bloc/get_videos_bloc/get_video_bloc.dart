import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/video_repository.dart';

part 'get_video_event.dart';
part 'get_video_state.dart';

class GetVideoBloc extends Bloc<GetVideoEvent, GetVideoState> {
  VideoRepo _videoRepo;
  GetVideoBloc(
      this._videoRepo
      ) : super(GetVideoInitial()) {
    on<GetVideo>((event, emit) async {
      emit(GetVideoLoading());
      try{
        List<Video> videos = await _videoRepo.getVideos();
        emit(GetVideoSuccess(videos));
      }
      catch(e){
        emit(GetVideoFailure());
      }
    });
  }
}
