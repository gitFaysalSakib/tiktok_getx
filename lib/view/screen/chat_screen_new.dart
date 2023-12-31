import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/view/widgets/text_input.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../controller/comment_controller.dart';

class ChatScreenNew extends StatelessWidget {
  final String id;
  ChatScreenNew({required this.id});

  final TextEditingController _commentControllerText = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostID(id);

    return Scaffold(
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
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final commentFetchData =
                            commentController.comments[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(commentFetchData.profilePic),
                          ),
                          title: Row(
                            children: [
                              Text(
                                commentFetchData.username,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                commentFetchData.comment,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(commentFetchData.datePub.toDate()),
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                commentFetchData.likes.length.toString(),
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          trailing: InkWell(
                            onTap: (){
                              commentController.likeUserComment(commentFetchData.commentId);
                              print(commentFetchData.commentId);
                            },
                             child: Icon(Icons.favorite , color : commentFetchData.likes.contains(FirebaseAuth.instance.currentUser!.uid) ? Colors.red : Colors.white)),
                        );
                      });
                }),
              ),
              Divider(),
              ListTile(
                title: TextInputField(
                    controller: _commentControllerText,
                    myIcon: Icons.comment,
                    myLabelText: "comment"),
                trailing: TextButton(
                  child: Text("Send"),
                  onPressed: () {
                    commentController.postComment(_commentControllerText.text);
                    
  
           },
                ),
              )
            ],
          )),
    ));
  }
}
