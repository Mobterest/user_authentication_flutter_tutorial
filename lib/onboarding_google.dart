import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:status_alert/status_alert.dart';
import 'firebase_options.dart';
import 'onboarding_welcome.dart';

class GoogleAuthentication extends StatefulWidget {
  const GoogleAuthentication({super.key});

  @override
  State<GoogleAuthentication> createState() => _GoogleAuthenticationState();
}

class _GoogleAuthenticationState extends State<GoogleAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.google,
        width: MediaQuery.of(context).size.width,
        onPressed: () async {
          try {
            final UserCredential userCredential = await signInWithGoogle();
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Welcome(
                            displayName: userCredential.user!.displayName!,
                            photoURL: userCredential.user!.photoURL ?? "",
                            email: userCredential.user!.email!,
                          )));
            }
          } catch (e) {
            StatusAlert.show(context,
                duration: const Duration(seconds: 2),
                title: 'User Authentication',
                subtitle: e.toString(),
                configuration: const IconConfiguration(
                    icon: Icons.close, color: Colors.red),
                maxWidth: 360);
          }
        },
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId: (DefaultFirebaseOptions.currentPlatform ==
                    DefaultFirebaseOptions.ios)
                ? DefaultFirebaseOptions.currentPlatform.iosClientId
                : DefaultFirebaseOptions.currentPlatform.androidClientId)
        .signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
