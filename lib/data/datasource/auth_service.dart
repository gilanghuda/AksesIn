import 'package:aksesin/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel> register(String email, String username, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCredential.user;
      await firebaseUser!.updateDisplayName(username);
      return UserModel(id: firebaseUser.uid, username: username, email: firebaseUser.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('An account already exists for that email.');
      } else {
        throw Exception(e.message ?? 'An error occurred.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCredential.user;
      return UserModel(id: firebaseUser!.uid, username: firebaseUser.displayName ?? '', email: firebaseUser.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('Gagal login, Cek koneksi internet anda');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Kata sandi yang anda masukkan salah');
      } else {
        throw Exception('Authentication failed. Please try again.');
      }
    } catch (e) {
      throw Exception('An unknown error occurred: ${e.toString()}');
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in aborted');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      return UserModel(id: firebaseUser!.uid, username: firebaseUser.displayName ?? '', email: firebaseUser.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'sign_in_failed') {
        throw Exception('Google sign-in failed. Please check your configuration.');
      } else {
        throw Exception('Google sign-in failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<Map<String, String?>> getUserProfile() async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('No user is currently signed in.');

    await user.reload();
    return {
      'name': user.displayName,
      'email': user.email,
    };
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}
