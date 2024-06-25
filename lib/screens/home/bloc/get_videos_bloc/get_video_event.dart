part of 'get_video_bloc.dart';

sealed class GetVideoEvent extends Equatable {
  const GetVideoEvent();

  @override
  List<Object> get props => [];
}

class GetVideo extends GetVideoEvent {}

