import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubeclone/screens/home/bloc/get_user_bloc/get_user_bloc.dart';

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
                    const SizedBox(height: 8,),
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
                          )
                        ],
                      ),
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
