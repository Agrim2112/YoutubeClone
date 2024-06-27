import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/video_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  SupabaseUserRepo _userRepo;
  GetUserBloc(
      this._userRepo
      ) : super(GetUserInitial()) {
    on<GetUser>((event, emit) async {
      emit(GetUserLoading());
      try{
        MyUser? user = await _userRepo.getUser();
        emit(GetUserSuccess(user!));
      }
      catch(e){
        emit(GetUserFailure());
        log(e.toString());
      }
    });

    on<UpdateUser>((event,emit) async{
      emit(UpdateUserLoading());
      try{
         await _userRepo.setUserData(event.myUser);
        emit(UpdateUserSuccess());
        emit(GetUserSuccess(event.myUser));
      }
      catch(e){
        emit(UpdateUserFailure());
        log(e.toString());
      }
    });
  }
}
