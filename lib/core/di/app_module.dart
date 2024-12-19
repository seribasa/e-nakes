import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
  @injectable
  SupabaseClient get supabaseClient => Supabase.instance.client;
  @injectable
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  @injectable
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
