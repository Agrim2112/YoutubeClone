import 'dart:async';
import 'dart:developer';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUserRepo implements UserRepository{

  final SupabaseClient _supabaseClient;

  SupabaseUserRepo({
    SupabaseClient? supabaseClient,
  }): _supabaseClient = supabaseClient ?? Supabase.instance.client;

  @override
  Stream<MyUser> get user {
    final controller = StreamController<MyUser>();

    _supabaseClient.auth.onAuthStateChange.listen((data) async {
      final Session? session = data.session;

      if (session == null) {
        controller.add(MyUser.empty);
      } else {
        final response = await _supabaseClient
            .from('Users')
            .select()
            .eq('userId', session.user.id)
            .limit(1);

        log(response.toString());

        if (response.isNotEmpty) {
          controller.add(MyUser.fromEntity(MyUserEntity.fromDocument(response[0])));
        } else {
          controller.add(MyUser.empty);
        }
      }
    });

    return controller.stream;
  }

  Future<MyUser?> getUser() async {
   final session = _supabaseClient.auth.currentSession;
   if(session!=null){
     final response = await _supabaseClient
         .from('Users')
         .select()
         .eq('userId', session.user.id)
         .limit(1);

     return MyUser.fromEntity(MyUserEntity.fromDocument(response[0]));
   }
   return null;
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _supabaseClient.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async{
    try {
      final response= await _supabaseClient.auth.signUp(
          email: myUser.email,
          password: password
      );

      myUser.userId = response.user!.id;

      return myUser;
    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async{
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async{
    try{
      await _supabaseClient
          .from('Users')
          .upsert(myUser.toEntity().toDocument());
    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }
}