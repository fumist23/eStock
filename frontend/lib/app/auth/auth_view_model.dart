import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/app/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authViewModelProvider =
    Provider<AuthViewModel>(((ref) => AuthViewModel()));

class AuthViewModel {
  final auth = FirebaseAuth.instance;

  bool islogedIn() {
    bool isLogedIn = false;
    User? user = auth.currentUser;
    if (user != null) {
      isLogedIn = true;
      return isLogedIn;
    }
    return isLogedIn;
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      CustomException(message: e.message);
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      CustomException(message: e.message);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
