import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/video_upload_data.dart';
import 'auth_controller.dart';

class VideoShowFromFirebaseInDisplay extends GetxController {
  final Rx<List<VideoUploadData>> _videoList = Rx<List<VideoUploadData>>([]);
  List<VideoUploadData> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .snapshots()
        .map((QuerySnapshot query) {
      List<VideoUploadData> videosDataList = [];
      for (var element in query.docs) {
        videosDataList.add(VideoUploadData.fromSnap(element));
      }
      return videosDataList;
    }));
  }

  //user video like count....
 likeVideoCount(String videoIdCheck) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("videos")
        .doc(videoIdCheck)
        .get();
        print(doc.exists);
     var loggedUserId = AuthController.instance.user.uid;
     print(loggedUserId);
    //var currentUserid = FirebaseAuth.instance.currentUser!.uid;
    if ((doc.data() as dynamic)["likes"].contains(loggedUserId)) {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoIdCheck)
          .update({
        'likes': FieldValue.arrayRemove([loggedUserId]),
      });
    } else {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoIdCheck)
          .update({
        'likes': FieldValue.arrayUnion([loggedUserId]),
      });
    }
  }
}
