import 'package:flutter/material.dart';

import 'onboarding.dart';
import 'onboarding_func.dart';

class Welcome extends StatefulWidget {
  final String photoURL;
  final String displayName;
  final String email;
  const Welcome(
      {required this.photoURL,
      required this.displayName,
      required this.email,
      super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with Func {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
        actions: [
          TextButton(
              onPressed: () {
                signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Onboarding()));
              },
              child: const Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (widget.photoURL.isEmpty)
              ? const SizedBox(
                  width: 100,
                  child: Placeholder(
                    fallbackHeight: 100,
                  ),
                )
              : ClipRRect(
                  child: Image.network(widget.photoURL),
                ),
          Text(
            widget.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            widget.email,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          )
        ],
      )),
    );
  }
}
