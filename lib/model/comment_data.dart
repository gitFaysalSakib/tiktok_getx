import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{

  String username;
  String comment;
  final datePub;
  List likes;
  String profilePic;
  String uid;
  String commentId; 

  Comment({
    required this.username,
    required this.comment,
    required this.datePub,
    required this.likes,
    required this.profilePic,
    required this.uid,
    required this.commentId,
});


  Map<String, dynamic> toJson()=>{
    'username' : username,
    'comment' : comment,
    'datePub' : datePub,
    'likes' : likes,
    'profilePic' : profilePic,
    'uid' : uid,
    'commentId' : commentId,
  };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username : snapshot['username'],
      comment : snapshot['comment'],
        datePub : snapshot['datePub'],
        likes : snapshot['likes'],
        profilePic : snapshot['profilePic'],
        uid : snapshot['uid'],
        commentId : snapshot['commentId'],
    );
  }
}