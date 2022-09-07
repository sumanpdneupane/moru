import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:moru/firebase/FirebaseAuthentication.dart';
import 'package:moru/utils/Commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationApi {
  FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? result =
          await firebaseAuthentication.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Commons.consoleLog(
        "AuthenticationApi::createUserWithEmailAndPassword---------->\n ${result.toString()}",
      );
      if (result == null) {
        Commons.consoleLog(
          "AuthenticationApi::createUserWithEmailAndPassword----------> Could not create account or account already created",
        );
      }
      return result;
    } catch (e) {
      Commons.consoleLog(
        "AuthenticationApi::createUserWithEmailAndPassword----------> ${e}",
      );
    }
    return null;
  }

  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential? result =
          await firebaseAuthentication.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result != null && result.user != null && result.user!.uid != null) {
        return result.user!.uid;
      }
      return null;
    } catch (e) {
      Commons.consoleLog("Something went wrong ${e}");
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential? result = await firebaseAuthentication.signInWithGoogle();
      if (result != null) {
        return result;
      }
      return null;
    } catch (e) {
      Commons.consoleLog("Something went wrong ${e}");
      return null;
    }
  }

  Future<String> silentLogin() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }
    return "";
  }

  Future<void> signOut() async {
    try {
      await firebaseAuthentication.signOut();
    } catch (e) {
      Commons.consoleLog("Something went wrong ${e}");
    }
  }
}
