import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user;
  }

  Future<User?> register(String name, String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await cred.user?.updateDisplayName(name);
    return cred.user;
  }

  Future<void> resetPassword(String email) => _auth.sendPasswordResetEmail(email: email);
  Future<void> signOut() => _auth.signOut();
  User? get currentUser => _auth.currentUser;
}