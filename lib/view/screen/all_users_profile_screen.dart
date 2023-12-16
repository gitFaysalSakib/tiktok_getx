import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/all_users_profile_controller.dart';
import '../../controller/auth_controller.dart';

class AllUsersProfileScreen extends StatefulWidget {
  final String id;
  AllUsersProfileScreen({required this.id});

  @override
  State<AllUsersProfileScreen> createState() => _AllUsersProfileScreenState();
}

class _AllUsersProfileScreenState extends State<AllUsersProfileScreen> {
  final AllUsersProfileController allUserProfileDatacontroller =
      Get.put(AllUsersProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    print(widget.id);
    //new start..
    setState(() {
      allUserProfileDatacontroller.fetchIdentifyUserByUserId(widget.id);
      allUserProfileDatacontroller.followFollowingCount(widget.id);
      allUserProfileDatacontroller.userAllVideoLikeCount(widget.id);
      allUserProfileDatacontroller.loginUserAllVideoShow(widget.id);
      allUserProfileDatacontroller.followUnFollowButtonCheck(widget.id);
    });

    //new end

    // allUserProfileDatacontroller
    //     .fetchFollowersFollowingInitionlResponse(widget.id);

    // allUserProfileDatacontroller.fetchUserByUserIdVideoId(widget.id);
    // var idcheck = allUserProfileDatacontroller
    //     .fetchFollowersFollowingInitionlResponse(widget.id);
    // print(idcheck);

    //print("allscreen");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PageView.builder(
          itemCount: allUserProfileDatacontroller.myUserModel.length,
          itemBuilder: (contex, index) {
            final userDatashowFromVideoProfile =
                allUserProfileDatacontroller.myUserModel[index];

            return Scaffold(
              appBar: AppBar(
                title: Text(userDatashowFromVideoProfile.name),
                actions: [
                  IconButton(
                    onPressed: () {
                      print("back");
                    },
                    icon: Icon(Icons.info_outline_rounded),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: SafeArea(
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userDatashowFromVideoProfile.profilePhoto,
                          fit: BoxFit.contain,
                          height: 100,
                          width: 100,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Followers",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              allUserProfileDatacontroller
                                  .getUserMapDataFollwFolling['followers']
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400))
                        ],
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Following',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              allUserProfileDatacontroller
                                  .getUserMapDataFollwFolling['following']
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400))
                        ],
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'likes',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              // allUserProfileDatacontroller
                              //     .getUserMapData['likes']
                              //     .toString(),
                              allUserProfileDatacontroller
                                  .getLikesCount['likes']
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  InkWell(
                    onTap: () {
                      if (FirebaseAuth.instance.currentUser!.uid ==
                          userDatashowFromVideoProfile.uid) {
                        allUserProfileDatacontroller.logoutChecking();
                      } else {
                        allUserProfileDatacontroller
                            .followUnfollowMethod(widget.id);
                      }

                      //  allUserProfileDatacontroller.clickFollowToAddFollowers(widget.id);
                    },
                    child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white60, width: 0.6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(FirebaseAuth.instance.currentUser!.uid ==
                                  userDatashowFromVideoProfile.uid
                              ? "Sign Out"
                              : allUserProfileDatacontroller
                                          .getFollowOrUnfollow['isFollowing'] ==
                                      true
                                  ? "Unfollow"
                                  : "Follow"),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5),
                    itemCount: allUserProfileDatacontroller
                            .getUserVideoThumnil['thumbnails']?.length ??
                        0,
                    itemBuilder: (context, index) {
                      String thumbnail = allUserProfileDatacontroller
                          .getUserVideoThumnil['thumbnails'][index];
                      return CachedNetworkImage(
                        imageUrl: thumbnail,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    },
                  )
                ]),
              )),
            );
          });
    });
  }
}
