import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      print("Something went wrong ${e}");
      return null;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      print("Something went wrong ${e}");
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    print(
      "accessToken= ${googleAuth.accessToken}\nidToken= ${googleAuth.idToken}",
    );

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }

  Future<void> signOut() async {
    if (_firebaseAuth != null) {
      await _firebaseAuth.signOut();
    }
    if (_googleSignIn != null) {
      final googleUser = await _googleSignIn.signOut();
    }
  }
}
