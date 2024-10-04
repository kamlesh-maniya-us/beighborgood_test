import 'package:flutter/material.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(StringConstants.errorScreen),
    );
  }
}
