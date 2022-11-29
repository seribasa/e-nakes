import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/klinik/data/models/klinik.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

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

  Future<UserCredential> signUpWithOTP(smsCode, verId) async {
    AuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    try {
      return await _firebaseAuth.signInWithCredential(credential);
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

  Future<void> insertUserToDatabase({
    required UserData user,
  }) async {
    final DocumentReference reference =
        _firestore.collection('users_medis').doc(user.id);
    await reference.set(user.toMap());
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserData?> getUser() async {
    final user = await _firestore
        .collection('users_medis')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    if (user.exists) {
      UserData userResult = UserData.fromMap(user.data(), user.id);

      final klinik = await _firestore
          .collection('klinik')
          .doc(user.data()?['clinicID'])
          .get();

      if (klinik.exists) {
        userResult = userResult.copyWith(
          clinic: Klinik.fromJson(
            klinik.data(),
          ).copyWith(
            id: klinik.id,
          ),
        );
      }
      return userResult;
    } else {
      return null;
    }
  }

  // add new and update avatar
  Future<void> updateUserAvatar(String url) => _firestore
      .collection('users_medis')
      .doc(_firebaseAuth.currentUser?.uid)
      .update({'photoURL': url});

  //Upload Image firebase Storage
  Future<String> uploadImage(File imageFile) async {
    final fileName = _firebaseAuth.currentUser?.uid ?? 'user';

    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    final result = await ref.putFile(imageFile);
    final fileUrl = await result.ref.getDownloadURL();
    return fileUrl;
  }
}
