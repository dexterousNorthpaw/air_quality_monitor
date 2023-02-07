import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return {'status': true, 'user': user};
    } catch (e) {
      return {'status': false, 'error': e.toString().split(']').last.trim()};
    }
  }
}
