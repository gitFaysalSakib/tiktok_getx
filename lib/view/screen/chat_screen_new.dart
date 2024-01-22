import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/controller/chat_screen_controller.dart';
import 'package:getx_tiktok/view/widgets/text_input.dart';


class ChatScreenNew extends StatefulWidget {
  final String id;
  ChatScreenNew({required this.id});

  @override
  State<ChatScreenNew> createState() => _ChatScreenNewState();
}

class _ChatScreenNewState extends State<ChatScreenNew> {
  final ChatScreenController chatScreenController =
      Get.put(ChatScreenController());
  final TextEditingController _messageBox = TextEditingController();

  @override
  void initState() {
    super.initState();
    //print(widget.id);
    //new start..
    setState(() {
      chatScreenController.fetchIdentifyUserByUserId(widget.id);
      chatScreenController.testMethor(widget.id);
    });

    //new end
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // commentController.updatePostID(id);

    return Scaffold(
      
      backgroundColor: const Color(0xff1B202D),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: chatScreenController.getMessagingTwo.length,
                    itemBuilder: (context, index) {
                      final chatFetchData =
                          chatScreenController.getMessagingTwo[index];
                           
                      return Column(
                        children: [
                         
                          // const Row(
                          //   children: [
                          //     // ProfileButton(
                          //     //     profilePhotoUrl: chatFetchData.profilePic),
                          //     //  SizedBox(
                          //     //   width: 5,
                          //     // ),
                          //   ],
                          // ),
                          // Padding(
                          //   padding:  const EdgeInsets.only(left: 250.0),
                             Row(
                               children: [
                                 Padding(
                                   padding:  const EdgeInsets.only(right: 300.0),
                                   child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color(0xff373E4E)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: 
                                          Text(
                                            chatFetchData.message,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                 ),
                                    
                               ],
                             ),
                            //  Row(
                            //    children: [
                            //      Container(
                            //               decoration: BoxDecoration(
                            //                   borderRadius: BorderRadius.circular(20),
                            //                   color: const Color(0xff373E4E)),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(10.0),
                            //                 child: 
                            //                 Text(
                            //                   chatFetchData.message,
                            //                   style: const TextStyle(
                            //                     color: Colors.white,
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //    ],
                            //  ),

                         // ),
                              const SizedBox(
                                height: 5,
                              ),
                              //  Center(
                              //   child: Text(
                              //   tago.format(chatFetchData.datePub.toDate()),
                              //   style: TextStyle(
                              //     fontSize: 10, fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),

                              // Padding(
                              //   padding: const EdgeInsets.only(right: 300.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(20),
                              //         color: Color(0xff7A8194)),
                              //     child: const Padding(
                              //       padding: EdgeInsets.all(10.0),
                              //       child: Text(
                              //         '',
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              
                              
                        ],
                      );
                    }
                    );
              }
              )
              ),
               Expanded(
                child: Obx(() {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: chatScreenController.getMessagingOne.length,
                    itemBuilder: (context, index) {
                      final chatFetchData =
                          chatScreenController.getMessagingOne[index];
                           
                      return Column(
                        children: [
                         
                          // const Row(
                          //   children: [
                          //     // ProfileButton(
                          //     //     profilePhotoUrl: chatFetchData.profilePic),
                          //     //  SizedBox(
                          //     //   width: 5,
                          //     // ),
                          //   ],
                          // ),
                          // Padding(
                          //   padding:  const EdgeInsets.only(left: 250.0),
                             Row(
                               children: [
                                 Padding(
                                   padding:  const EdgeInsets.only(left: 300.0),
                                   child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color(0xff373E4E)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: 
                                          Text(
                                            chatFetchData.message,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                 ),
                                    
                               ],
                             ),
                            //  Row(
                            //    children: [
                            //      Container(
                            //               decoration: BoxDecoration(
                            //                   borderRadius: BorderRadius.circular(20),
                            //                   color: const Color(0xff373E4E)),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(10.0),
                            //                 child: 
                            //                 Text(
                            //                   chatFetchData.message,
                            //                   style: const TextStyle(
                            //                     color: Colors.white,
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //    ],
                            //  ),

                         // ),
                              const SizedBox(
                                height: 5,
                              ),
                              //  Center(
                              //   child: Text(
                              //   tago.format(chatFetchData.datePub.toDate()),
                              //   style: TextStyle(
                              //     fontSize: 10, fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),

                              // Padding(
                              //   padding: const EdgeInsets.only(right: 300.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(20),
                              //         color: Color(0xff7A8194)),
                              //     child: const Padding(
                              //       padding: EdgeInsets.all(10.0),
                              //       child: Text(
                              //         '',
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              
                              
                        ],
                      );
                    }
                    );
              }
              )
              ),
              
             
              const Divider(),
              ListTile(
                title: TextInputField(
                    controller: _messageBox,
                    myIcon: Icons.comment,
                    myLabelText: "message"),
                trailing: TextButton(
                  child: const Text("Send"),
                  onPressed: () {
                     chatScreenController.chatMethod(_messageBox.text,widget.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
