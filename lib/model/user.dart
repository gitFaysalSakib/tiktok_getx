import 'package:cloud_firestore/cloud_firestore.dart';

class myUser{
  late String name;
  late String profilePhoto;
  late String email;
  late String uid;

  myUser({
    required this.name,
   required this.email,
   required this.profilePhoto,
   required this.uid

  }

  );

  Map<String , dynamic> toJson() => {
      "name" : name,
      "profilePic" : profilePhoto,
      "email" : email,
      "uid" : uid
    };

    static myUser fromSnap( DocumentSnapshot snap){

    var snapshot = snap.data() as Map<String , dynamic>;
    return myUser(
      email: snapshot['email'],
      profilePhoto: snapshot["profilePic"],
      uid: snapshot["uid"],
      name: snapshot["name"]
    );

  }

}