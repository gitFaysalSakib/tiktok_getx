import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/user.dart';

class SearchUserNameController extends GetxController {
  final Rx<List<myUser>> _searchUsers = Rx<List<myUser>>([]);

  List<myUser> get getSearchFromUserModel => _searchUsers.value;

//fetch user data from User Model class and store in _searchUers....
  searchUserName(String queryByUserName) {
    _searchUsers.bindStream(FirebaseFirestore.instance
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: queryByUserName)
        .snapshots()
        .map((QuerySnapshot queryRes) {
      List<myUser> retVal = [];
      for (var element in queryRes.docs) {
        retVal.add(myUser.fromSnap(element));
      }
      return retVal;
    }));
  }
}
