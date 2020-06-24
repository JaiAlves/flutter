import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/helpers/firebase_erros.dart';
import 'package:lojavirtual/models/user.dart';

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  Future<void> signIn({User user, Function onFail, Function onSuccsess} ) async {
    setLoading(true);
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
                              email: user.email,
                              password: user.password);
      onSuccsess();
    } on PlatformException catch(e) {
      onFail(getErrorString(e.code));
    }

    setLoading(false);
  }

  void setLoading(bool value) {
    loading = value;
  }
}