import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractUserApi {
  Stream<User> get authUser;

  Future<User> getAuthUser();

  Future<User> signUp({String email, String password});

  Future<User> signIn({String email, String password});

  Future<void> signOut();
}
