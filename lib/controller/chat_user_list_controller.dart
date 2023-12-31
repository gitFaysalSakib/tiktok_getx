import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/model/user.dart';

class ChatUserListController extends GetxController {
    final Rx<List<myUser>> _userList = Rx<List<myUser>>([]);
  List<myUser> get userList => _userList.value;

  @override
  void onInit() {
    super.onInit();
   
    _userList.bindStream(FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<myUser> userDataList = [];
      for (var element in query.docs) {
        userDataList.add(myUser.fromSnap(element));
      }
      return userDataList;
    }));
  }

  
}
