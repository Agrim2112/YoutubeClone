import 'package:flutter/material.dart';

import '../../components/image_item.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 35,
            child: ImageItem(
              imageName: "channel.png",
              itemClicked: () {},
              itemText: "Your Channel",
              haveColor: false,
            ),
          ),
          const SizedBox(height: 6.5),
          SizedBox(
            height: 34,
            child: ImageItem(
              imageName: "incognito.png",
              itemClicked: () {},
              itemText: "Turn on Incognito",
              haveColor: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6, bottom: 6),
            child: Divider(
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(
            height: 35,
            child: ImageItem(
              imageName: "youtube.png",
              itemClicked: () {},
              itemText: "Purchases and Membership",
              haveColor: false,
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            height: 31,
            child: ImageItem(
              imageName: "analytics.png",
              itemClicked: () {},
              itemText: "Time watched",
              haveColor: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6, bottom: 6),
            child: Divider(
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(
            height: 33,
            child: ImageItem(
              imageName: "setting.png",
              itemClicked: () {},
              itemText: "Settings",
              haveColor: false,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 35,
            child: ImageItem(
              imageName: "help.png",
              itemClicked: () {},
              itemText: "Help & feedback",
              haveColor: false,
            ),
          ),
        ],
      ),
    );;
  }
}
