import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user =
          await _firestore.collection('users').doc(result.user!.uid).get();
      final displayName = user['name'] as String;

      await result.user!.updateDisplayName(displayName);

      return result.user!;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUp({
    required email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(result.user!.uid).set({
        'uid': result.user!.uid,
        'name': name,
        'email': email,
      });

      await result.user!.updateDisplayName(name);
      return result.user!;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        final name = userDoc['name'] as String;
        final email = userDoc['email'] as String;

        await user.updateDisplayName(name);
        await user.updateEmail(email);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
