import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:youtubeclone/screens/auth/pages/login_screen.dart';
import 'package:youtubeclone/screens/auth/pages/sign_up_screen.dart';
import 'package:youtubeclone/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://oktfpbcaciaokovloemt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9rdGZwYmNhY2lhb2tvdmxvZW10Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTkxNzE0NjIsImV4cCI6MjAzNDc0NzQ2Mn0.thNTI5HT3zS4lwOLjV7TzSpefAYhjvbBCBhGaEkwM4E',
  );
  Bloc.observer= SimpleBlocObserver();
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: MyApp(SupabaseUserRepo())));
}


