import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'onboarding_func.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with Func {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Create an account",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(hintText: "Enter email address"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: "Enter password"),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await signUpWithEmailAndPassword(
                              emailController.text, passwordController.text);
                          if (context.mounted) {
                            callCustomStatusAlert(context,
                                "Now sign in with your new credentials", true);
                          }
                        } on FirebaseException catch (e) {
                          if (e.code == 'weak-password') {
                            callCustomStatusAlert(context,
                                'The password provided is too weak', false);
                          } else if (e.code == 'email-already-in-use') {
                            callCustomStatusAlert(
                                context,
                                'The account already exists for that email',
                                false);
                          }
                        } catch (e) {
                          callCustomStatusAlert(context, e.toString(), false);
                        }
                      },
                      child: const Text("Sign Up"))),
            )
          ],
        ),
      )),
    );
  }
}
