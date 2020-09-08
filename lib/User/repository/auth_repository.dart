import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    _firebaseAuth.signInWithCredential(credential);

    User currentUser = _firebaseAuth.currentUser;

    if (currentUser != null) {
      print("Usuario no ha podido iniciar sesion");
    }

    return _firebaseAuth.currentUser;
  }

  signOutWithGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }
}
