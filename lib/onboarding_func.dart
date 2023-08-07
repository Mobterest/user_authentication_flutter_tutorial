import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:status_alert/status_alert.dart';

mixin Func {
  callCustomStatusAlert(BuildContext context, String subtitle, bool success) {
    return StatusAlert.show(context,
        duration: const Duration(seconds: 2),
        title: "User Authentication",
        subtitle: subtitle,
        configuration: IconConfiguration(
            icon: (success) ? Icons.check : Icons.close,
            size: 50,
            color: (success) ? Colors.blue : Colors.red),
        maxWidth: 360);
  }

  //Email & Password Authentication - Sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  //Email & Password Authentication - Sign up
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  //sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //Biometric Authentication
  Future<bool> signInWithBiometrics(BuildContext context) async {
    bool canCheckBiometrics = await LocalAuthentication().canCheckBiometrics;

    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await LocalAuthentication().getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.fingerprint) ||
          availableBiometrics.contains(BiometricType.face)) {
        try {
          bool isAuthenticated = await LocalAuthentication().authenticate(
              localizedReason:
                  'Authenticate to access the User Authentication app');
          return isAuthenticated;
        } catch (e) {
          if (context.mounted) {
            callCustomStatusAlert(context, e.toString(), false);
          }
        }
      }
    }
    return false;
  }
}
