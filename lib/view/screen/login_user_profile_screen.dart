import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/controller/login_user_profile_controller.dart';

class LoginUserProfileScreen extends StatefulWidget {
  final String id;
  LoginUserProfileScreen({required this.id});

  @override
  State<LoginUserProfileScreen> createState() => _LoginUserProfileScreenState();
}

class _LoginUserProfileScreenState extends State<LoginUserProfileScreen> {
  final LoginUserProfileController loginUserProCon =
      Get.put(LoginUserProfileController());
  @override
  void initState() {
    loginUserProCon.fetchUserTableForID(widget.id);
    loginUserProCon.followFollowing();
    loginUserProCon.loginUserAllVideoLikeCount();
    loginUserProCon.loginUserAllVideoShow();
    super.initState();

  }

  

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PageView.builder(
          itemCount: loginUserProCon.getMyUserModel.length,
          itemBuilder: (contex, index) {
            final userModelIndex = loginUserProCon.getMyUserModel[index];
            return Scaffold(
              appBar: AppBar(
                title: Text(userModelIndex.name),
                actions: [
                  IconButton(
                    onPressed: () {

                      
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
                          imageUrl: userModelIndex.profilePhoto,
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
                              loginUserProCon.getUserMapData['followers']
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
                              loginUserProCon.getUserMapData['following']
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
                            'Likes',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              loginUserProCon.getLikesCount['likes'].toString(),
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
                      loginUserProCon.logoutChecking();
                    },
                    child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white60, width: 0.6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text("Sign Out"),
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
                    itemCount: loginUserProCon
                            .getUserVideoThumnil['thumbnails']?.length ??
                        0,
                    itemBuilder: (context, index) {
                      String thumbnails = loginUserProCon
                          .getUserVideoThumnil['thumbnails'][index];
                      return CachedNetworkImage(
                        imageUrl: thumbnails,
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
