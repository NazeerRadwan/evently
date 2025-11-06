import 'package:evently/core/source/remote/FirestoreManager.dart';
import 'package:evently/models/User.dart' as MyUser;
import 'package:evently/ui/login/screen/Google_AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser.User? user;

  Future<MyUser.User?> getUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No user is currently signed in");
        return null;
      }

      print("Fetching user with ID: ${currentUser.uid}");
      user = await FirestoreManager.getUser(currentUser.uid);

      if (user != null) {
        print("Retrieved user: ${user?.id}");
        notifyListeners();
      } else {
        print("No user data found in Firestore");
      }
      return user;
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  Future<MyUser.User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        user = await FirestoreManager.getUser(credential.user!.uid);
        if (user != null) {
          notifyListeners();
        }
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      rethrow;
    }
  }

  Future<MyUser.User?> signInWithGoogle() async {
    try {
      final GoogleAuthService googleAuth = GoogleAuthService();
      final userCredential = await googleAuth.signInWithGoogle();
      if (userCredential?.user != null) {
        user = await FirestoreManager.getUser(userCredential!.user!.uid);
        if (user != null) {
          notifyListeners();
        }
        return user;
      }
      return null;
    } catch (e) {
      print("Google Sign In Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      user = null;
      notifyListeners();
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }

  Future<MyUser.User?> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        user = MyUser.User(id: credential.user?.uid, email: email, name: name);

        await FirestoreManager.addUser(user!);
        notifyListeners();
      }

      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
