import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/meals_cubit.dart';

class MealsErrorWidget extends StatelessWidget {
  final String message;

  const MealsErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MealsCubit>().getMeals();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
