// ignore_for_file: file_names



import 'package:auction_app/models/user.model.dart';
import 'package:auction_app/pages/auth/firstPage.dart';
import 'package:auction_app/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
   RxBool isLoading = true.obs ;
  late Rx<UserModel> userData;
  getIsLoading()=> isLoading.value ;
  getUserData()=> userData ;
  getUser() => _user.value;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {

      Get.offAll(() => const AuthMain());
    } else {
      getCurrentUserData();
      Get.offAll(() => const HomePage()); 
    }
  }

  void createUser(String email, String password , String cin , String firstName , String lastName , String phone ,) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) => 

            FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(
              {
                'firstName' : firstName , 
                'lastName' : lastName , 
                'phone' : phone , 
                'cin' : cin , 
                'email' : email , 

              }
            )

          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Mot de passe invalide", "",
            backgroundColor: Colors.white,
            colorText: Color.fromARGB(255, 199, 13, 0));
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("email non valide", "",
            backgroundColor: Colors.white,
            colorText: Color.fromARGB(255, 199, 13, 0));
      }
    }
  }

  void loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found");
        Get.snackbar("Utilisateur non trouvé", "verifier votre email",
            backgroundColor: Colors.white,
            colorText: Color.fromARGB(255, 199, 13, 0));
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Mot de passe incorrecte", "",
            backgroundColor: Colors.white,
            colorText: Color.fromARGB(255, 199, 13, 0));
      }
    }
  }

 
    // Once signed in, return the UserCredential


  void getCurrentUserData() async {
  isLoading(true);
  try {
    print(_user.value!.uid);
    
    // Use await to get the data from Firestore
    var snapshot = await FirebaseFirestore.instance.collection('users').doc(_user.value!.uid).get();
    
    // Check if the document exists before converting data
    print(snapshot.data());
    if (snapshot.exists) {
      userData.value = UserModel.fromJson(snapshot.data()!);
      print(userData.value);
    } else {
      userData.value = UserModel.fromJson(snapshot.data()!);
      print('User data not found');
    }
  } catch (error) {
    print('Error fetching user data: $error');
    // Handle the error accordingly
  } finally {
    isLoading(false);
  }
}

  void signOut() => _auth.signOut();

}