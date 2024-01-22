import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/chat_screen_controller.dart';
import '../widgets/profile_button.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  ChatScreen({required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatScreenController chatScreenController =
      Get.put(ChatScreenController());
  final TextEditingController _commentControllerText = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatScreenController.fetchIdentifyUserByUserId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() {
      return PageView.builder(
          itemCount: chatScreenController.getMessagingOne.length,
          itemBuilder: (context, index) {
            final userData = chatScreenController.getMessagingOne[index];

            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      print("back");
                    },
                    icon: Icon(Icons.info_outline_rounded),
                  )
                ],
              ),
              backgroundColor: Color(0xff1B202D),
              body: Padding(
                padding: EdgeInsets.only(left: 14.0, right: 14),

                child: SingleChildScrollView(
                  // width: size.width,
                  // height: size.height,

                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ProfileButton(
                                      profilePhotoUrl: userData.profilePic),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    userData.message,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: ('Quicksand'),
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  const Icon(
                                    Icons.search_rounded,
                                    color: Colors.white70,
                                    size: 40,
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff373E4E)),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'userData.message',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  '08:12',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff7A8194)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'I commented on Figma, I want to add\n sjdiw weosjwy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              
                            ],
                          ),
                        ),

                        
              
                      ],
                    ),
                  ),
                ),

                //   //Spacer(),
                // Padding(
                //     padding: const EdgeInsets.only(bottom: 8.0),
                //     child: Container(
                //       height: 45,
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(30),
                //           color: Color(0xff3D4354)),
                //       child: Row(children: [
                //         Padding(
                //           padding: const EdgeInsets.all(4.0),
                //           child: Container(
                //             height: 40,
                //             width: 40,
                //             decoration: BoxDecoration(
                //                 color: Colors.white30,
                //                 borderRadius: BorderRadius.circular(50)),
                //             child: Icon(Icons.camera_alt_outlined),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         const Text(
                //           'Message',
                //           style: TextStyle(color: Colors.white54),
                //         ),
                //         Spacer(),
                //         const Padding(
                //           padding: EdgeInsets.only(right: 8.0),
                //           child: Icon(
                //             Icons.send,
                //             color: Colors.white54,
                //           ),
                //         ),
                //       ]),
                //     )

                //     )
              ),
            );
          });
    });
  }
}
