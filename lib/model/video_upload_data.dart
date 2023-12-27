import 'package:cloud_firestore/cloud_firestore.dart';

class VideoUploadData{
  String username;
  String uid;
  String videoId;
  List likes;
  int commentsCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String thumbnailId;

  String profilePics;


  VideoUploadData({
   required this.username,
    required this.uid,
  required this.thumbnail,
    required this.thumbnailId,

  required this.caption,
  required this.commentsCount,
  required this.videoId,
  required this.likes,
  required this.profilePics,
  required this.shareCount,
  required this.songName,
  required this.videoUrl

  }

  );

  Map<String , dynamic> toJson() => {
    "username" : username,
    "uid" : uid,
    "profilePics" : profilePics,
    "videoId" : videoId,
    "likes" : likes,
    "commentsCount" : commentsCount,
    "shareCount" : shareCount,
    "songName" : songName,
    "caption" : caption,
    "videoUrl" : videoUrl,
    "thumbnail" : thumbnail,
    "thumbnailId" : thumbnailId

    };

    static VideoUploadData fromSnap( DocumentSnapshot snap){

    var snapshot = snap.data() as Map<String , dynamic>;

    return VideoUploadData(
      username: snapshot["username"],
      uid: snapshot["uid"],
      videoId: snapshot["videoId"],
      likes: snapshot["likes"],
      commentsCount:  snapshot['commentsCount'],
      caption:  snapshot["caption"],
      shareCount: snapshot["shareCount"],
      songName: snapshot["songName"],
      thumbnail: snapshot["thumbnail"],
      thumbnailId: snapshot["thumbnailId"],

      profilePics: snapshot["profilePics"],
      videoUrl: snapshot["videoUrl"]
    );

  }

}