import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_tiktok/view/screen/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user.dart';
import '../view/screen/auth/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proimg;

//image pick from divice gallery method..
  void pickImage() async {
    print("IMAGE PICKED SUCCESSFULLY");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    final img = File(image!.path);
    this.proimg = img;
  }

//user signUp by firebase authentication..
  void SignUp(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        print("sakib");
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        _uploadProPic(image!);
        String downloadUrl = await _uploadProPic(image);

        myUser createUser = myUser(
            name: username,
            email: email,
            profilePhoto: downloadUrl,
            uid: credential.user!.uid);
        //  print(user.name);
        // print('check');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(createUser.toJson());
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  //login...
  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error Logging In", "Please enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error Logging In", e.toString());
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }

  //login state check any user login or not..and if login then go to home scrren when app open..
  late Rx<User?> _user;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);

    //Rx - Observable Keyword - Continously Checking Variable Is Changing Or Not.
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(LoginScreen());
    } else {
      Get.offAll(HomeScreen());
    }
  }
}
