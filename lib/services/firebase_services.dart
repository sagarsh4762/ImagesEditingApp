// ignore_for_file: use_rethrow_when_possible, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignAccount =
          await _googleSignIn.signIn();
      if (googleSignAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
