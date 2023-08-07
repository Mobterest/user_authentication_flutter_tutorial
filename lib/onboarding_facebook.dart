import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:status_alert/status_alert.dart';

import 'onboarding_welcome.dart';

class FacebookAuthentication extends StatefulWidget {
  const FacebookAuthentication({super.key});

  @override
  State<FacebookAuthentication> createState() => _FacebookAuthenticationState();
}

class _FacebookAuthenticationState extends State<FacebookAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.facebook,
        width: MediaQuery.of(context).size.width,
        onPressed: () async {
          try {
            final UserCredential userCredential = await signInWithFacebook();
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

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
