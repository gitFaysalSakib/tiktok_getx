import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/message_data.dart';

class ChatScreenController extends GetxController {
 // final Rx<List<myUser>> _myUserModel = Rx<List<myUser>>([]);
    final Rx<List<Messsaging>> _messagingOne = Rx<List<Messsaging>>([]);
     List<Messsaging> get getMessagingOne => _messagingOne.value;

        final Rx<List<Messsaging>> _messagingTwo = Rx<List<Messsaging>>([]);
            List<Messsaging> get getMessagingTwo => _messagingTwo.value;


      //  List<Messsaging> messagingQueryList = [];



 // List<myUser> get myUserModel => _myUserModel.value;
 // List<myUser> myUserQueryList = [];

  fetchIdentifyUserByUserId(String idPassFromAllUserProfile) {
        var currentUserIdGet = FirebaseAuth.instance.currentUser!.uid;

    _messagingOne.bindStream(FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserIdGet)
        .collection("messageWith").doc(idPassFromAllUserProfile).collection("message")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Messsaging> messagingQueryList = [];
      for (var element in query.docs) {
        messagingQueryList.add(Messsaging.fromSnap(element));
      }

      return messagingQueryList;
    }));
  }

  testMethodAgain(String idPassFromAllUserProfile){
     var currentUserIdGet = FirebaseAuth.instance.currentUser!.uid;

   
  }

  testMethor(String userid)async{
        var currentUserIdGet = FirebaseAuth.instance.currentUser!.uid;

     var getUser = await FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: userid)
            .get();
        int len = getUser.docs.length;
        //print(len);
        List<String> userId = [];
        var pairMessageingUserid;

        for (int i = 0; i < len; i++) {
          userId.add((getUser.docs[i].data() as dynamic)['uid']);
          pairMessageingUserid = userId[i];
         // print(pairMessageingUserid);

          update();
        }
          print(pairMessageingUserid);

         var checkUsersSendMeesageORnot = await FirebaseFirestore.instance
            .collection("users")
            .doc(pairMessageingUserid)
            .collection("messageWith")
            .doc(currentUserIdGet).collection("message")
            .get();
           // print(checkUsersSendMeesageORnot.exists);
           var lenght = checkUsersSendMeesageORnot.docs.length;
            // if(checkUsersSendMeesageORnot.exists){
            //   print("messag send");
            // }else{
            //   print("Message not send");
            // }
            print(lenght);
             _messagingTwo.bindStream(FirebaseFirestore.instance
        .collection("users")
        .doc(pairMessageingUserid)
        .collection("messageWith").doc(currentUserIdGet).collection("message")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Messsaging> messagingQueryList = [];
      for (var element in query.docs) {
        messagingQueryList.add(Messsaging.fromSnap(element));
      }

      return messagingQueryList;
    }));
  }

  //  chat infor unload firebase and fetch..
  chatMethod(String messageTextCheck, String userid) async {
   // print(userid);
    var currentUserIdGet = FirebaseAuth.instance.currentUser!.uid;
    try {
      if (messageTextCheck.isNotEmpty) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserIdGet)
            .get();

        var getUser = await FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: userid)
            .get();
        int len = getUser.docs.length;
        //print(len);
        List<String> userId = [];
        var pairMessageingUserid;

        for (int i = 0; i < len; i++) {
          userId.add((getUser.docs[i].data() as dynamic)['uid']);
          pairMessageingUserid = userId[i];
          print(pairMessageingUserid);

          update();
        }

         var allDocs = await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserIdGet)
            .collection("messageWith")
            .doc(pairMessageingUserid)
            .collection("message")
            .get();
        int alldocLenght = allDocs.docs.length;

       

        Messsaging messaginDataModel = Messsaging(
            message: messageTextCheck.trim(),
            datePub: DateTime.now(),
            uid: FirebaseAuth.instance.currentUser!.uid,
            messageID: 'MessageCount $alldocLenght',
            profilePic: (userDoc.data() as dynamic)['profilePic'],
            );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserIdGet)
            .collection("messageWith")
            .doc(pairMessageingUserid)
            .collection("message")
            .doc('MessageCount $alldocLenght')
            .set(messaginDataModel.toJson());

           
        // int len = allDocs.docs.length;
        // print(len);

        // Comment commentDataModel = Comment(                 
        //     username: (userDoc.data() as dynamic)['name'],
        //     comment: commentTextCheck.trim(),
        //     datePub: DateTime.now(),
        //     likes: [],
        //     profilePic: (userDoc.data() as dynamic)['profilePic'],
        //     uid: FirebaseAuth.instance.currentUser!.uid,
        //     commentId: 'Comment $len');

        // await FirebaseFirestore.instance
        //     .collection("videos")
        //     .doc(_videoIdGetFromDisplay)
        //     .collection("comments")
        //     .doc('Comment $len')
        //     .set(commentDataModel.toJson());

        // DocumentSnapshot videosDataGet = await FirebaseFirestore.instance
        //     .collection('videos')
        //     .doc(_videoIdGetFromDisplay)
        //     .get();

        // await FirebaseFirestore.instance
        //     .collection('videos')
        //     .doc(_videoIdGetFromDisplay)
        //     .update({
        //   'commentsCount':
        //       (videosDataGet.data() as dynamic)['commentsCount'] + 1,
        // });
      } else {
        Get.snackbar(
            "Please Enter some content", "Please write something in comment");
      }
    } catch (e) {
      Get.snackbar("Error in sending comment", e.toString());
    }
  }
}
