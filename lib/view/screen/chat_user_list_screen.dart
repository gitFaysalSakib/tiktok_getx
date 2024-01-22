import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/view/screen/chat_screen_new.dart';
import 'package:getx_tiktok/view/widgets/profile_button.dart';

import '../../controller/chat_user_list_controller.dart';

class ChatUserListScreen extends StatefulWidget {
  const ChatUserListScreen({super.key});

  @override
  State<ChatUserListScreen> createState() => _ChatUserListScreenState();
}

class _ChatUserListScreenState extends State<ChatUserListScreen> {
  final ChatUserListController chatListUserContro =
      Get.put(ChatUserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 9, 15, 30),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Message',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: ('Quicksand'),
                    fontSize: 30,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 36,
                  ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'R E C E N T',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CircleAvatar(
              //   radius: 30,
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Perez',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          SizedBox(
            width: 25,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 555,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff292F3F),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Obx(() {
              return ListView.builder(
                  itemCount: chatListUserContro.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final userDataFromControler =
                        chatListUserContro.userList[index];

                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // print(userDataFromControler.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (ChatScreenNew(
                                        id: userDataFromControler.uid))));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 26.0, top: 35, right: 10),
                            child: Row(children: [
                              ProfileButton(
                                  profilePhotoUrl:
                                      userDataFromControler.profilePhoto),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        userDataFromControler.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: ('Quicksand'),
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        width: 200,
                                      ),
                                      Text(
                                        '08:43',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                      ],
                    );
                  });
            }),
          )
        ],
      )),
    );
  }
}
