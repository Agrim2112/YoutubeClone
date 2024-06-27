import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubeclone/screens/home/screens/profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/get_user_bloc/get_user_bloc.dart';
import 'home_tab.dart';

enum TabItem { home, add, profile }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, Widget> _screens = {
    TabItem.home: const HomeTabScreen(),
    TabItem.profile: const ProfileScreen(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == TabItem.add) {
      showModalBottomSheet(context: context,
          builder: (BuildContext context) {
            return Material(
              child: Container(
                  color: Colors.black.withOpacity(0.9),
                  child: Wrap(
                      children: <Widget>[
                        ListTile(
                          selectedTileColor: Colors.grey.shade500,
                          leading: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                color: Colors.grey.shade800),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Icon(
                                CupertinoIcons.arrow_up,
                                color: Colors.grey.shade100,
                                size: 20,
                              ),
                            ),
                          ),
                          title: Text(
                            'Upload a Video',
                            style: TextStyle(
                                color: Colors.grey.shade100
                            ),
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          selectedTileColor: Colors.grey.shade500,
                          leading: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                color: Colors.grey.shade800),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/shorts.png',
                                height: 28,
                                width: 28,
                              ),
                            ),
                          ),
                          title: Text(
                            'Upload a Short',
                            style: TextStyle(
                                color: Colors.grey.shade100
                            ),
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                      ]
                  )
              ),
            );
          });
    }
    else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<GetUserBloc, GetUserState>(
        builder: (context, state) {
          if (state is GetUserSuccess) {
            return Scaffold(
              body: _screens[_currentTab],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                selectedFontSize: 12.0,
                selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w600
                ),
                unselectedFontSize: 12.0,
                items: [
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          (_currentTab == TabItem.home) ? CupertinoIcons
                              .house_fill : CupertinoIcons.house,
                        ),
                      ),
                      label: "Home"
                  ),
                  const BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(CupertinoIcons.add),
                    ),
                    label: "Upload",
                  ),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child:CircleAvatar(
                          radius: 17,
                          backgroundColor: (_currentTab==TabItem.profile)? Colors.white : Colors.transparent,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(state.user.profilePic),
                          ),
                        )
                      ),
                      label: "Profile")
                ],
                currentIndex: _currentTab.index,
                onTap: (index) => _selectTab(TabItem.values[index]),
              ),
            );
          }
          else if(state is GetUserLoading){
            return Scaffold(body: CircularProgressIndicator(color: Colors.grey.shade100,));
          }
          else{
            return const Scaffold(body:Center(
              child: Text(
                'An error occurred, please try again.'
              ),
            ));
          }
        }
      ),
    );
  }
}
