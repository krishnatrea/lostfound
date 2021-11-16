import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_found_pet_prototype/api/abstract_user_api.dart';

class UserApi implements AbstractUserApi {
  final _auth = FirebaseAuth.instance;

  @override
  Stream<User> get authUser {
    return _auth.authStateChanges();
  }

  @override
  Future<User> signUp({String email, String password}) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  @override
  Future<User> signIn({String email, String password}) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<User> getAuthUser() async {
    return await _auth.currentUser;
  }
}
