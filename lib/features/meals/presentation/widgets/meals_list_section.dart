import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/meal_entity.dart';
import 'grid_meal_card.dart';

class MealsListSection extends StatelessWidget {
  final List<MealEntity> meals;

  const MealsListSection({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final meal = meals[index];
          return GridMealCard(meal: meal, onFavoriteTap: () {});
        }, childCount: meals.length),
      ),
    );
  }
}
