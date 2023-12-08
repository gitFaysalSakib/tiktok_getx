import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/view/screen/comment_screent.dart';
import 'package:getx_tiktok/view/widgets/tiktok_video_player.dart';

import '../../controller/video_show_indisplay_fromfirebase_controller.dart';
import '../widgets/album_rotator.dart';
import '../widgets/profile_button.dart';
import 'all_users_profile_screen.dart';

class DisplayVideoScreen extends StatefulWidget {
  DisplayVideoScreen({super.key});

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  final VideoShowFromFirebaseInDisplay videoFirebaseController =
      Get.put(VideoShowFromFirebaseInDisplay());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
      return PageView.builder(
          scrollDirection: Axis.vertical,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          itemCount: videoFirebaseController.videoList.length,
          itemBuilder: (context, index) {
            final data = videoFirebaseController.videoList[index];

            return Stack(
              children: [
                TikTokVideoPlayer(
                  videoUrl: data.videoUrl,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.username,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      Text(
                        data.caption,
                      ),
                      Text(
                        data.songName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 400,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        (AllUsersProfileScreen(
                                            id: data.videoId))));
                            });
                            
                            print(data.videoId);
                          },
                          child: ProfileButton(
                            profilePhotoUrl: data.profilePics,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            videoFirebaseController
                                .likeVideoCount(data.videoId);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 35,
                                color: Colors.white,
                              ),
                              Text(
                                data.likes.length.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.reply,
                              size: 35,
                              color: Colors.white,
                            ),
                            Text(
                              data.shareCount.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        (CommentScreen(id: data.videoId))));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.comment,
                                size: 35,
                                color: Colors.white,
                              ),
                              Text(
                                data.commentsCount.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  AlbumRotator(profilePicUrl: data.profilePics)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    }));
  }
}
