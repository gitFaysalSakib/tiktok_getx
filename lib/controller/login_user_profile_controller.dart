import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/model/user.dart';

import '../model/video_upload_data.dart';
import 'auth_controller.dart';

class LoginUserProfileController extends GetxController {
  final AuthController authController = Get.put(AuthController());

  final Rx<List<myUser>> _myUserModel = Rx<List<myUser>>([]);
  List<myUser> get getMyUserModel => _myUserModel.value;

  final Rx<Map<String, dynamic>> _userMapDataFollowFollowing = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getUserMapData => _userMapDataFollowFollowing.value;

  final Rx<Map<String, dynamic>> _onlyLikesCount = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getLikesCount => _onlyLikesCount.value;

 final Rx<Map<String, dynamic>> _userVideoThumnil = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getUserVideoThumnil => _userVideoThumnil.value;

  final Rx<List<VideoUploadData>> _videoDataModel =
      Rx<List<VideoUploadData>>([]);
  List<VideoUploadData> get videoDataModel => _videoDataModel.value;


  //  final Rx<List<VideoUploadData>> _videoDataModel =
  //     Rx<List<VideoUploadData>>([]);
  // List<VideoUploadData> get videoDataModel => _videoDataModel.value;
  //     List<VideoUploadData> videoList = [];

  fetchUserTableForID(String uid) {
    // print(uid);

    _myUserModel.bindStream(FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<myUser> myUserDataList = [];
      for (var element in query.docs) {
        myUserDataList.add(myUser.fromSnap(element));
      }

      return myUserDataList;
    }));
  }

  followFollowing() async {
    var followersDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("followers")
        .get();
    int followersLenght = 0;
    followersLenght = followersDoc.docs.length;
    // print(followersLenght);

    var followingDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("following")
        .get();

    int followingLength = 0;
    followingLength = followingDoc.docs.length;
    // print(followingLength);

    _userMapDataFollowFollowing.value = {
      'following': followingLength.toString(),
      'followers': followersLenght.toString()
    };

    update();
  }

  
  loginUserAllVideoLikeCount() async {
    List<String> likecount = [];
    int totalLikeSum = 0;

    var myVideos = await FirebaseFirestore.instance
        .collection("videos")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    // print(myVideos.docs.length);
    for (int i = 0; i < myVideos.docs.length; i++) {
      likecount
          .add((myVideos.docs[i].data() as dynamic)['likes'].length.toString());

      update();
    }
    for (int i = 0; i < likecount.length; i++) {
      totalLikeSum = int.parse(likecount[i]) + totalLikeSum;
    }

     _onlyLikesCount.value = {
      'likes': totalLikeSum,
     
    };

    //print(totalLikeSum);
  }



  loginUserAllVideoShow()async{
    List<String> thumbnails = [];

    var myVideos = await FirebaseFirestore.instance
        .collection("videos")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
      print(thumbnails.length);
      update();
    }

 _userVideoThumnil.value = {
      'thumbnails': thumbnails,
     
    };

  }

  logoutChecking() {
  
      authController.signOut();
   
    }
  

 
}
