import 'package:classifield_app/models/user.dart';
import 'package:classifield_app/services/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  var authServices = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(UserModel user) async {
    if (user.userEmail.isEmpty ||
        user.userPassword.isEmpty ||
        user.userName.isEmpty) {
      return 'Please fill the fields';
    } else {
      try {
        UserCredential ref = await authServices.createUserWithEmailAndPassword(
            email: user.userEmail, password: user.userPassword);
        user.userId = ref.user!.uid;
        await DbServices().saveUserToDatabase(user);

        return 'Success';
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill the fields';
    } else {
      try {
        await authServices.signInWithEmailAndPassword(
            email: email, password: password);
        return 'Success';
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<void> signOut() async {
    await authServices.signOut();
  }
}
