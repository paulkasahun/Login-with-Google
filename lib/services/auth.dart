import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
//google signin
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await guser!.authentication;
    //create a new credentials for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally let the credentials sign in

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
