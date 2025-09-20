import 'package:flutter/material.dart';

class MealsEmptyWidget extends StatelessWidget {
  const MealsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No meals available', style: TextStyle(fontSize: 16)),
    );
  }
}
