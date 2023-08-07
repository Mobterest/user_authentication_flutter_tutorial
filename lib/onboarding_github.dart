import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

import 'onboarding_func.dart';
import 'onboarding_welcome.dart';

class GithubAuthentication extends StatefulWidget {
  const GithubAuthentication({super.key});

  @override
  State<GithubAuthentication> createState() => _GithubAuthenticationState();
}

class _GithubAuthenticationState extends State<GithubAuthentication> with Func {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.github,
        width: MediaQuery.of(context).size.width,
        onPressed: () async {
          try {
            UserCredential userCredential = await signInWithGithub();
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
            callCustomStatusAlert(context, e.toString(), false);
          }
        },
      ),
    );
  }

  Future<UserCredential> signInWithGithub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  }
}
