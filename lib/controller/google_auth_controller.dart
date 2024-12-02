import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_track/firebase_options.dart';
import 'package:googleapis/gmail/v1.dart';
import '../model/user_model.dart';

class GoogleAuthController {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    AppleAuthProvider.APPLE_SIGN_IN_METHOD,
    GmailApi.gmailReadonlyScope
  ]);
  static CustomUser? user;

  static Future<void> logIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      var authClient = _googleSignIn.authenticatedClient();

      // GmailApi ciao = GmailApi(authClient);

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential authUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      user = CustomUser(authUser.user?.uid, authUser.user?.displayName,
          authUser.user?.email, authUser.user?.photoURL);

      print(authUser.user?.email);
    } catch (ex) {
      print(ex.toString());
    }
  }

//   Future<String> generateAppPassword() async {
//   // Imposta l'ID client e la chiave segreta della tua app su Google Cloud Console
//   final clientId = '991499020070-brkqmb3p6h5a5ocq49f4k1bjitp93vcs.apps.googleusercontent.com';
//   final clientSecret = DefaultFirebaseOptions.android.;

//   // Specifica il nome dell'app per cui stai generando la password (es. 'Gmail', 'Calendario', ecc.)
//   final appName = 'il_tuo_nome_app';

//   // Crea un oggetto di autenticazione client
//   final client = await clientViaUserConsent(
//     Credentials.fromJson({
//       'client_id': clientId,
//       'client_secret': clientSecret,
//       'scopes': ['https://www.googleapis.com/auth/cloud-platform'],
//       'token_uri': 'https://accounts.google.com/o/oauth2/token',
//       'authorization_uri': 'https://accounts.google.com/o/oauth2/auth',
//     }),
//     ['https://www.googleapis.com/auth/cloud-platform'],
//     prompt: Prompt.AUTO,
//   );

//   // Richiedi un token OAuth 2.0 con il privilegio necessario
//   final credentials = await client.credentials;
//   final appPassword = await credentials.fetchAppPassword(appName);

//   return appPassword;
// }

  static void logOut() {
    _googleSignIn.signOut();
    user?.destroy();
  }
}
