import 'package:flutter/material.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(StringConstants.search),
      ),
    );
  }
}
