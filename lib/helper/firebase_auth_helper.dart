import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthHelper {
  FireBaseAuthHelper._();
  static final FireBaseAuthHelper fireBaseAuthHelper = FireBaseAuthHelper._();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  //------------------------------------------------------------------------
  Future<User?> singInAnonymous() async {
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'admin-restricted-operation':
          print("restricted");
          break;
        case 'operation-not-allowed':
          print("not allowed");
          break;
      }
    }
    return null;
  }

  //------------------------------------------------------------------------
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

//------------------------------------------------------------------------
  Future<User?> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          print("Weak Password");
          break;
        case 'email-already-in-use':
          print("Exist");
          break;
      }
    }
    return null;
  }

//------------------------------------------------------------------------
  Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          print("wrong");
          break;
        case 'user-not-found':
          print("not created");
          break;
      }
    }
    return null;
  }

  Future<User?> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;
    return user;
  }
}
