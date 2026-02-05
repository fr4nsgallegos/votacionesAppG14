import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:votacionesappg14/pages/home_page.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSingInInitialized = false;
  GoogleSignInAccount? _account;
  List<String> scopes = [
    "email",
    "https://www.googleapis.com/auth/contacts.readonly",
  ];

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSingInInitialized = true;
    } catch (e) {
      print("error al inicilizar google: $e");
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSingInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount?> getGoogleAccount() async {
    await _ensureGoogleSignInInitialized();
    GoogleSignInAccount? account;
    try {
      account = await _googleSignIn.authenticate(scopeHint: scopes);
      _account = account;
      print(_account);
      return _account;
    } on GoogleSignInException catch (e) {
      print("Error en google sign in: $e");
    } catch (e) {
      print("Ocurrió un problema: $e");
    }
  }

  static Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error en Firebase ${e.message}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<User?> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return userCredential.user;
    } on FirebaseAuth catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Errror: $e")));
    } catch (e) {
      print("Error: $e");
    }
  }
}
