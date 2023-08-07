import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'onboarding_func.dart';
import 'onboarding_welcome.dart';

class PasswordAuthentication extends StatefulWidget {
  const PasswordAuthentication({super.key});

  @override
  State<PasswordAuthentication> createState() => _PasswordAuthenticationState();
}

class _PasswordAuthenticationState extends State<PasswordAuthentication>
    with Func {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "Password Authentication",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: "Enter email address"),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(hintText: "Enter password"),
          obscureText: true,
        ),
        Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    final UserCredential userCredential =
                        await signInWithEmailAndPassword(
                            emailController.text, passwordController.text);

                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Welcome(
                                    displayName:
                                        userCredential.user!.displayName ?? "",
                                    photoURL:
                                        userCredential.user!.photoURL ?? "",
                                    email: userCredential.user!.email!,
                                  )));
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      callCustomStatusAlert(
                          context, 'No user found for that email', false);
                    } else if (e.code == 'wrong-password') {
                      callCustomStatusAlert(context,
                          'Wrong password provided for that user', false);
                    }
                  } catch (e) {
                    callCustomStatusAlert(context, e.toString(), false);
                  }
                },
                child: const Text("Sign in")))
      ],
    );
  }
}
