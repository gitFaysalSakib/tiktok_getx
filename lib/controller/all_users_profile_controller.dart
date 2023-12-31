import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/model/user.dart';

import '../model/video_upload_data.dart';
import 'auth_controller.dart';

class AllUsersProfileController extends GetxController {
  List<VideoUploadData> videoDataList = [];
  // final Rx<List<myUser>> _userDataModel = Rx<List<myUser>>([]);
  // List<myUser> get userDataModel => _userDataModel.value;
  final AuthController authController = Get.put(AuthController());

  final Rx<Map<String, dynamic>> _userVideoThumnil =
      Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getUserVideoThumnil => _userVideoThumnil.value;

  final Rx<Map<String, dynamic>> _userVideoId = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getUserVideoId => _userVideoId.value;

  final Rx<Map<String, dynamic>> _isFollowOrNot = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getFollowOrUnfollow => _isFollowOrNot.value;

  final Rx<Map<String, dynamic>> _onlyLikesCount = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getLikesCount => _onlyLikesCount.value;

  final Rx<Map<String, dynamic>> _userMapDataFollowFollowing =
      Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getUserMapDataFollwFolling =>
      _userMapDataFollowFollowing.value;
//
  final Rx<Map<String, dynamic>> _userMapData = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get getUserMapData => _userMapData.value;

  //video data model..
  final Rx<List<VideoUploadData>> _videoDataModel =
      Rx<List<VideoUploadData>>([]);
  List<VideoUploadData> get getVideoDataModel => _videoDataModel.value;
  List<VideoUploadData> videoDataQueryList = [];

  final Rx<List<myUser>> _myUserModel = Rx<List<myUser>>([]);
  List<myUser> get myUserModel => _myUserModel.value;
  List<myUser> myUserQueryList = [];

  Rx<String> _uid = "".obs;

  //new method apply..start ..

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

  followFollowingCount(String idPassFromAllUserProfile) async {
    var followersDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(idPassFromAllUserProfile)
        .collection("followers")
        .get();
    int followersLenght = 0;
    followersLenght = followersDoc.docs.length;

    var followingDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(idPassFromAllUserProfile)
        .collection("following")
        .get();

    int followingLength = 0;
    followingLength = followingDoc.docs.length;

    _userMapDataFollowFollowing.value = {
      'following': followingLength.toString(),
      'followers': followersLenght.toString()
    };

    update();
  }

  userAllVideoLikeCount(String idPassFromAllUserProfile) async {
    List<String> likecount = [];
    int totalLikeSum = 0;

    var myVideos = await FirebaseFirestore.instance
        .collection("videos")
        .where("uid", isEqualTo: idPassFromAllUserProfile)
        .get();
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
  }




   

     

  userAllVideoShowByThumbnil(String idPassFromAllUserProfile) async {
    List<String> thumbnails = [];
        List<String> thumbnailId = [];



    var myVideos = await FirebaseFirestore.instance
        .collection("videos")
        .where("uid", isEqualTo: idPassFromAllUserProfile)
        .get();
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
            thumbnailId.add((myVideos.docs[i].data() as dynamic)['thumbnailId']);


      update();
    }

    _userVideoThumnil.value = {
      'thumbnails': thumbnails,
      'thumbnailId': thumbnailId,
    };

  }


  

  bool isFollowing = false;

  followUnFollowButtonCheck(String idPassFromAllUserProfile) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(idPassFromAllUserProfile)
        .collection("followers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
      _isFollowOrNot.value = {
        'isFollowing': isFollowing,
      };
    });
    update();
  }

  clickFollowToAddFollowers(String idPassFromAllUserProfile) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(idPassFromAllUserProfile)
        .collection("followers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({});
    _isFollowOrNot.value.update('isFollowing', (value) => !value);

//after click follow button current users following table add this follow users id..
//this code is below..
    var getFollowersWhenClickFollowButton = await FirebaseFirestore.instance
        .collection("users")
        .doc(idPassFromAllUserProfile)
        .collection("followers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(getFollowersWhenClickFollowButton.exists);

    if (getFollowersWhenClickFollowButton.exists) {
     // print("login user found");

      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("following")
          .doc(idPassFromAllUserProfile)
          .set({});
    } else {
      //print("not found");
    }
  }

  unfollowButtonClick(String idPassFromAllUserProfile) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(idPassFromAllUserProfile)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
   // print(doc.exists);
    var loggedUserId = AuthController.instance.user.uid;
   // print(loggedUserId);
    //var currentUserid = FirebaseAuth.instance.currentUser!.uid;
    if (doc.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(idPassFromAllUserProfile)
          .collection('followers')
          .doc(loggedUserId)
          .delete();
      _isFollowOrNot.value.update('isFollowing', (value) => !value);

      //print('dddddd');
    }
  }

  followUnfollowMethod(String idPassFromAllUserProfile) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(idPassFromAllUserProfile)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
   // print(doc.exists);
    if (doc.exists) {
      unfollowButtonClick(idPassFromAllUserProfile);
    } else {
      clickFollowToAddFollowers(idPassFromAllUserProfile);
    }
  }

  logoutChecking() {
    authController.signOut();
  }
  //nwe method apply --EEEEENNNNNDDDDDDDDDDDDDD....
}
