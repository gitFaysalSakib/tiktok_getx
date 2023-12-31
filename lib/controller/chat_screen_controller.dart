import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/model/user.dart';

class ChatScreenController extends GetxController {
  final Rx<List<myUser>> _myUserModel = Rx<List<myUser>>([]);
  List<myUser> get myUserModel => _myUserModel.value;
  List<myUser> myUserQueryList = [];


  fetchIdentifyUserByUserId(String idPassFromAllUserProfile) {
    _myUserModel.bindStream(FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: idPassFromAllUserProfile)
        .snapshots()
        .map((QuerySnapshot query) {
      List<myUser> myUserQueryList = [];
      for (var element in query.docs) {
        myUserQueryList.add(myUser.fromSnap(element));
      }

      return myUserQueryList;
    }));
  }
}
