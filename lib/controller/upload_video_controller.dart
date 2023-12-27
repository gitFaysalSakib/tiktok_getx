import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../model/video_upload_data.dart';

class VideoUploadController extends GetxController {
  static VideoUploadController instance = Get.find();

  //id generator for upload video..
  var uuid = Uuid();


  //main method to upload video..
   uploadVideo(String songName, String caption, String videoPath) async {

    String uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    // print(userDoc);
    String videoId = uuid.v1();
     String videoUrlGenerate = await _uploadVideoToStorage(videoId, videoPath);

    // print(videoUrlGenerate);
    String thumbnail = await _uploadVideoThumbToStorage(videoId, videoPath);
        print("thumbnail");


    VideoUploadData videoModel = VideoUploadData(
        uid: uid,
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        videoUrl: videoUrlGenerate,
        thumbnail: thumbnail,
        songName: songName,
        shareCount: 0,
        commentsCount: 0,
        likes: [],
        profilePics: (userDoc.data()! as Map<String, dynamic>)['profilePic'],
        caption: caption,
        videoId: videoId,
        thumbnailId: videoId
        
        );

        await FirebaseFirestore.instance
        .collection("videos").doc(videoId).set(videoModel.toJson());

  }

  //thumbnail generator method..
  Future<File> _getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  //video thumbnil upload on firebase storage method..
  Future<String> _uploadVideoThumbToStorage(String id , String videoPath) async{
  Reference reference = 
  FirebaseStorage.instance.ref().child("thumbnail").child(id);
  UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

  //video upload on firebase storage method...
  _uploadVideoToStorage(String videoId, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("videosStore").child(videoId);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //video compression method..
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);

    return compressedVideo!.file;
  }
}
