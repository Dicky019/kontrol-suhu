import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  // final _firebaseFirestore = FirebaseFirestore.instance;
  // CollectionReference<ModelAuth> get _firebaseCollection =>
  //     _firebaseFirestore.collection("user").withConverter(
  //           fromFirestore: (snapshot, options) =>
  //               ModelAuth.fromMap(snapshot.data()!,snapshot.id),
  //           toFirestore: (value, options) => value.toMap(),
  //         );

  User? get userCurrent => _firebaseAuth.currentUser;

  // Future<DocumentSnapshot<ModelAuth>> modelAuth(String id) async =>
  //     await _firebaseCollection.doc(id).get();

  Future<UserCredential?> loginAdmin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> loginAdminWeb() async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      // googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);

    } on FirebaseAuthException catch (e) {
      log(e.code);
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> loginAnonimus() async {
    try {
      return await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    } on FirebaseAuthException catch (e) {
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
  }
}
