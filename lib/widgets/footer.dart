import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black12,
      child: Center(
        child: Text(
          "© 2025 TAPP AI Transcriber. All rights reserved.",
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5), fontSize: 12),
        ),
      ),
    );
  }
}
