import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/video_repository.dart';
import 'package:youtubeclone/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:youtubeclone/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:youtubeclone/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:youtubeclone/screens/auth/pages/sign_up_screen.dart';
import 'package:youtubeclone/screens/home/bloc/get_videos_bloc/get_video_bloc.dart';
import 'package:youtubeclone/screens/home/screens/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        SignInBloc(
                            context
                                .read<AuthenticationBloc>()
                                .userRepository
                        ),
                  ),
                  BlocProvider(
                    create: (context) => GetVideoBloc(
                        FirebaseVideoRepo()
                    )..add(GetVideo()),
                  ),
                ],
                child: const HomeScreen(),
              );
            }
            else {
              return BlocProvider<SignUpBloc>(
                create: (context) => SignUpBloc(
                    context.read<AuthenticationBloc>().userRepository
                ),
                child: const SignUpScreen(),
              );
            }
          }
          );
  }
}
