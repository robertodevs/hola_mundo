import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
