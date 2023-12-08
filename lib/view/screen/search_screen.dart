import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/search_user_controller.dart';
import '../../model/user.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchQuery = TextEditingController();
  final SearchUserNameController searchController =
      Get.put(SearchUserNameController());

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
                  child: Text("Search Users!"),
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
                        print(user.uid);
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
