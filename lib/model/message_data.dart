import 'package:cloud_firestore/cloud_firestore.dart';

class Messsaging{

  String message;
  final datePub;
  String uid;
  String messageID; 
  String profilePic;


  Messsaging({
    required this.message,
    required this.datePub,
    required this.uid,
    required this.messageID,
    required this.profilePic,

});


  Map<String, dynamic> toJson()=>{
    'message' : message,
    'datePub' : datePub,
    'uid' : uid,
    'messageID' : messageID,
    'profilePic' : profilePic,

  };

  static Messsaging fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Messsaging(
      message : snapshot['message'],
        datePub : snapshot['datePub'],
        uid : snapshot['uid'],
        messageID : snapshot['messageID'],
        profilePic : snapshot['profilePic'],

    );
  }
}