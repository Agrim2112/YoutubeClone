import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubeclone/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:youtubeclone/screens/home/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:youtubeclone/screens/home/screens/items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.arrow_right_to_line),
                color: Colors.white.withOpacity(0.7),
                onPressed: (){
                  context.read<SignInBloc>().add(SignOutRequired());
                },
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width/20),
              Icon(
                CupertinoIcons.bell,
                color: Colors.white.withOpacity(0.7),
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width/20),
              Icon(
                CupertinoIcons.search,
                color: Colors.white.withOpacity(0.7),
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width/20),
            ],
          ),

        ],
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<GetUserBloc,GetUserState>(
          builder: (context,state) {
            if(state is GetUserSuccess) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 45,
                            child: Image.asset(
                              'assets/avatar.png',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  color: Colors.grey.shade300
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                '@${state.user.email}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    color: Colors.grey.shade500
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: const Items(),
                    )
                  ],
                ),
              );
            }
            else if(state is GetUserLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return const Center(
                child: Text(
                  "An error occurred, please try again.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
