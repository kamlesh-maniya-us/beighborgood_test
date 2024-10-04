import 'package:flutter/material.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(StringConstants.chatScreen),
      ),
    );
  }
}
