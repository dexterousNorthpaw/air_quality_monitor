import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return {'status': true, 'user': user};
    } catch (e) {
      return {'status': false, 'error': e.toString().split(']').last.trim()};
    }
  }

  static void logout() async {
    await auth.signOut();
  }
}
