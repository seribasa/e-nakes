import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> forgetEmailPassword({required String email}) {
    return _firebaseAuth.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> verifyPhoneNumber(
      {required String phone,
      required void Function(String, int?) codeSent,
      required void Function(FirebaseAuthException) verificationFailed}) {
    return _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
    );
  }

  Future<void> signUpWithOTP(smsCode, verId) async {
    AuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    try {
      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserData?> getUser() async {
    return UserData(
      id: _firebaseAuth.currentUser!.uid,
      email: _firebaseAuth.currentUser!.email,
      phone: _firebaseAuth.currentUser!.phoneNumber,
      name: _firebaseAuth.currentUser!.displayName,
    );
  }
}
