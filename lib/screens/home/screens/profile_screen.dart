import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:youtubeclone/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:youtubeclone/screens/home/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:youtubeclone/screens/home/screens/items.dart';
import 'package:image_picker/image_picker.dart';

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
                        Stack(
                        alignment: Alignment.center, // Add this line
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 45,
                            backgroundImage:(state.user.profilePic.isNotEmpty
                                ?NetworkImage(state.user.profilePic)
                                : const AssetImage('assets/avatar.png')
                            ) as ImageProvider<Object>?
                          ),
                          IconButton(
                            icon: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black.withOpacity(0.3)),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey.shade100,
                                  size: 20,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                              if(image==null) {
                              return;
                              }
                              final imageBytes= await image.readAsBytes();
                              final filePath = Uuid().v4();
                              await Supabase.instance.client.storage.from("videos/profile").uploadBinary(filePath.toString(), imageBytes);
                              final imageUrl = Supabase.instance.client.storage.from("videos/profile").getPublicUrl(filePath.toString());

                              state.user.profilePic=imageUrl;
                              if(mounted) {
                              context.read<GetUserBloc>().add(UpdateUser(state.user));
                            }
                            },
                          )
                        ],
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
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Items(),
                      ),
                    )
                  ],
                ),
              );
            }
            else if(state is GetUserLoading || state is UpdateUserLoading){
              return Center(
                child: CircularProgressIndicator(color: Colors.grey.shade100,),
              );
            }
            else{
              return const Scaffold(
                  body: Center(
                  child: Text(
                  "An error occurred, please try again.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ));
            }
          }
      ),
    );
  }
}
