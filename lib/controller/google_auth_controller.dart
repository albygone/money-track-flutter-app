import 'package:realm/realm.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class GoogleAuthController {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static CustomUser? user;

  static Future<void> logIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      var accessToken = googleAuth?.accessToken ?? "";

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential auth_user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      user = CustomUser(auth_user.user?.uid, auth_user.user?.displayName,
          auth_user.user?.email, auth_user.user?.photoURL);
    } catch (ex) {
      print(ex.toString());
    }
  }

  static void logOut() {
    _googleSignIn.signOut();
    user?.destroy();
  }
}
