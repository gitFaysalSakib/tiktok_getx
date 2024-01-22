import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/comment_data.dart';

class CommentController extends GetxController {
  String _videoIdGetFromDisplay = "";
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  updatePostID(String id) {
    _videoIdGetFromDisplay = id;
    fetchComment();
  }

  //fetch user data from firebase....
  fetchComment() async {
    _comments.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .doc(_videoIdGetFromDisplay)
        .collection("comments")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> commentListOfFirebaseData = [];
      for (var element in query.docs) {
        commentListOfFirebaseData.add(Comment.fromSnap(element));
      }
      return commentListOfFirebaseData;
    }));
  }

// user post comment on video methd uplod to firebase..
  postComment(String commentTextCheck) async {
    var currentUserIdGet = FirebaseAuth.instance.currentUser!.uid;
    try {
      if (commentTextCheck.isNotEmpty) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserIdGet)
            .get();
        var allDocs = await FirebaseFirestore.instance
            .collection("videos")
            .doc(_videoIdGetFromDisplay)
            .collection("comments")
            .get();
        int len = allDocs.docs.length;
        print(len);

        Comment commentDataModel = Comment(
            username: (userDoc.data() as dynamic)['name'],
            comment: commentTextCheck.trim(),
            datePub: DateTime.now(),
            likes: [],
            profilePic: (userDoc.data() as dynamic)['profilePic'],
            uid: FirebaseAuth.instance.currentUser!.uid,
            commentId: 'Comment $len');

        await FirebaseFirestore.instance
            .collection("videos")
            .doc(_videoIdGetFromDisplay)
            .collection("comments")
            .doc('Comment $len')
            .set(commentDataModel.toJson());

        DocumentSnapshot videosDataGet = await FirebaseFirestore.instance
            .collection('videos')
            .doc(_videoIdGetFromDisplay)
            .get();

        await FirebaseFirestore.instance
            .collection('videos')
            .doc(_videoIdGetFromDisplay)
            .update({
          'commentsCount':
              (videosDataGet.data() as dynamic)['commentsCount'] + 1,
        });
      } else {
        Get.snackbar(
            "Please Enter some content", "Please write something in comment");
      }
    } catch (e) {
      Get.snackbar("Error in sending comment", e.toString());
    }
  }

  //user likes to comment on others user comment...
  likeUserComment(String commentId) async {
    var currentUser = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot videoDoc = await FirebaseFirestore.instance
        .collection("videos")
        .doc(_videoIdGetFromDisplay)
        .collection('comments')
        .doc(commentId)
        .get();

    print(currentUser);

    if ((videoDoc.data() as dynamic)['likes'].contains(currentUser)) {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(_videoIdGetFromDisplay)
          .collection("comments")
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayRemove([currentUser]),
      });
      print(currentUser);
    } else {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(_videoIdGetFromDisplay)
          .collection("comments")
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayUnion([currentUser]),
      });
      print(currentUser);
    }
  }
}
