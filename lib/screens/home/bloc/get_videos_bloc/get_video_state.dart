part of 'get_video_bloc.dart';

sealed class GetVideoState extends Equatable{
  const GetVideoState();

  @override
  List<Object> get props => [];
}

final class GetVideoInitial extends GetVideoState {
}

final class GetVideoFailure extends GetVideoState{}

final class GetVideoLoading extends GetVideoState{}

final class GetVideoSuccess extends GetVideoState{
  final List<Video> videos;

  const GetVideoSuccess(this.videos);

  @override
  List<Object> get props => [videos];
}

