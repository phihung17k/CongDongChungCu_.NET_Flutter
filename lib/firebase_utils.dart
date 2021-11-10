import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'log.dart';
import 'repository/user_repository.dart';

class FirebaseUtils {
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;
    if (googleAuth != null) {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  static Future logout() async {
    if ((await GoogleSignIn().isSignedIn()) == true) {
      GetIt.I.get<UserRepository>().reset();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
      Log.i("sign out successfully");
    }
  }

  static Future saveUserImage(int userId, String imagePath) async {
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection("user_image");
    await collection.doc("$userId").set({"image_path": imagePath});
    Log.i("save user image successfully");
  }

  static Future<dynamic> getUserImage(int userId) async {
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection("user_image");
    DocumentSnapshot<Map<String, dynamic>> data =
        await collection.doc("$userId").get();
    if (data.exists) {
      Map<String, dynamic> temp = data.data();
      return temp['image_path'];
    }
  }

  static Future uploadFile(String filePath, String filename, String directory) async {
    File file = File(filePath);
    try {
      bool isExist = await file.exists();
      if (isExist) {
        await FirebaseStorage.instance.ref("$directory/$filename").putFile(file);
        Log.i("upload file successfully");
      } else {
        Log.e("File is not exist");
      }
    } catch (e) {
      Log.e(e.message);
    }
  }



  static Future<String> getImageUrl(String directory, int id) async {
    String result = "";
    try{
      String fullPath = FirebaseStorage.instance.ref("$directory/$id").fullPath;
      result = await FirebaseStorage.instance.ref(fullPath).getDownloadURL();
    } catch (e) {
      Log.e("Not found file in firebase storage");
    }
    return result;
  }

  static Future<Map<String, String>> getMapImageUrl(String directory) async {
    Map<String, String> result = {};
    ListResult resultList = await FirebaseStorage.instance.ref(directory).listAll();
    for (var ref in resultList.items) {
      String imagePath =
          await FirebaseStorage.instance.ref(ref.fullPath).getDownloadURL();
      String imageName = ref.name.split(".")[0];
      result[imageName] = imagePath;
    }
    return result;
  }
}

//upload file
// ImagePicker imagePicker = ImagePicker();
// final XFile image = await imagePicker.pickImage(
//     source: ImageSource.gallery);
// await FirebaseUtils.uploadFile(image.path, image.name);
//get a file
// String fullPath = await FirebaseStorage.instance
//     .ref("post/image_picker3270196239813020889.png")
//     .fullPath;
// String imageUrl = await FirebaseUtils.getImageUrl(fullPath);
// print("imageUrl $imageUrl");
//get list
// Map<String, String> map = await FirebaseUtils.getMapImageUrl("post");
// print("map $map");
