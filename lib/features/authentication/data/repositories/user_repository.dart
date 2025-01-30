import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../models/user.dart';

@injectable
class UserRepository {
  final SupabaseClient _supabaseClient;

  UserRepository(
    this._supabaseClient,
  );

  Stream<AuthState> get onAuthStateChange {
    return _supabaseClient.auth.onAuthStateChange;
  }

  Future<AuthResponse> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> forgetEmailPassword({
    required String email,
  }) {
    return _supabaseClient.auth.resetPasswordForEmail(
      email,
    );
  }

  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> insertUserToDatabase({
    required ProfileModel user,
  }) async {
    try {
      await _supabaseClient.auth.updateUser(
        UserAttributes(
          email: user.email,
        ),
      );
      final userResult = user.toSeribaseMap();
      final userId = _supabaseClient.auth.currentUser!.id;
      return await _supabaseClient
          .from(ProfileModel.tableName)
          .update(
            userResult,
          )
          .eq(
            'user_id',
            userId,
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> isUserExist() async {
    final isSignedIn = await this.isSignedIn();
    final getUser = await this.getUser();
    final isUserExist = getUser != null;
    if (isSignedIn && isUserExist) {
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    return await _supabaseClient.auth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _supabaseClient.auth.currentUser;
    return currentUser != null;
  }

  Future<ProfileModel?> getUser() async {
    final user = _supabaseClient.auth.currentUser;
    final userExpand =
        await _supabaseClient.from(ProfileModel.tableName).select().eq(
              'user_id',
              user!.id,
            );
    if (userExpand.isNotEmpty) {
      final userResult = ProfileModel.fromSeribase(userExpand.first);
      return userResult.copyWith(
        email: user.email,
      );
    } else {
      return null;
    }
  }

  Future<void> updateUserAvatar(String url) async {
    try {
      if (_supabaseClient.auth.currentUser == null) {
        throw Exception('User not found');
      }
      await _supabaseClient
          .from(ProfileModel.tableName)
          .update({'avatar_url': url}).eq(
        'user_id',
        _supabaseClient.auth.currentUser!.id,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<String> uploadImage(File file) async {
    try {
      final id = _supabaseClient.auth.currentUser?.id;
      await _supabaseClient.storage.from('avatars').upload(
            '$id',
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
            retryAttempts: 3,
          );
      final fullPath =
          _supabaseClient.storage.from('avatars').getPublicUrl('$id');
      await CachedNetworkImage.evictFromCache(fullPath);
      return fullPath;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logInWithSeribaseOauth() async {
    return await _supabaseClient.auth.signInWithOAuth(
      supabase.OAuthProvider.keycloak,
      scopes: 'openid',
    );
  }
}
