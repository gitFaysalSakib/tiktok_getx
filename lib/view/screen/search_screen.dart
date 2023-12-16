import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/controller/all_users_profile_controller.dart';
import 'package:getx_tiktok/view/screen/all_users_profile_screen.dart';
import 'package:getx_tiktok/view/screen/login_user_profile_screen.dart';

import '../../controller/search_user_controller.dart';
import '../../controller/video_show_indisplay_fromfirebase_controller.dart';
import '../../model/user.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchQuery = TextEditingController();
  final SearchUserNameController searchController =
      Get.put(SearchUserNameController());

  final VideoShowFromFirebaseInDisplay videoFirebaseController =
      Get.put(VideoShowFromFirebaseInDisplay());

  final AllUsersProfileController allContro =
      Get.put(AllUsersProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "search user name",
              ),
              controller: searchQuery,
              onChanged: (value) {
                searchController.searchUserName(value);
              },
            ),
          ),
          body: searchController.getSearchFromUserModel.isEmpty
              ? Center(
                  child: Text("Search User name!"),
                )
              : ListView.builder(
                  itemCount: searchController.getSearchFromUserModel.length,
                  itemBuilder: (context, index) {
                    myUser user =
                        searchController.getSearchFromUserModel[index];
                    // print(user.name);
                    // print(user.uid);

                    return ListTile(
                      onTap: () {
                        if (user.uid ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (LoginUserProfileScreen(
                                        id: user.uid,
                                      ))));

                          print(user.uid);
                          print("allContro.videoDataModel[index].uid");
                        } else {
                          print(user.uid);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (AllUsersProfileScreen(
                                        id: user.uid,
                                      ))));
                          print("another users id");
                        }
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePhoto),
                      ),
                      title: Text(
                        user.name,
                      ),
                    );
                  }));
    });
  }
}
