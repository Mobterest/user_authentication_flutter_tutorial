import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: const Divider(
              thickness: 1,
            ),
          ),
          const Text(
            " or ",
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: const Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
