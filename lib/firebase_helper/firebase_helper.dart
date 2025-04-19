import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signUp(String email, String password) async {
  try {
    UserCredential u = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> SignIn(String email, String password) async {
  try {
    UserCredential u = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } catch (e) {
    return false;
  }
}

Future<void> SignOut() async {
  await FirebaseAuth.instance.signOut();
}
