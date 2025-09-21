import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/meal_entity.dart';
import 'grid_meal_card.dart';

class MealsListSection extends StatefulWidget {
  final List<MealEntity> meals;
  final int animationDelayMs;

  const MealsListSection({
    super.key,
    required this.meals,
    this.animationDelayMs = 150,
  });

  @override
  State<MealsListSection> createState() => _MealsListSectionState();
}

class _MealsListSectionState extends State<MealsListSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<AnimationController> _itemAnimationControllers;
  late List<Animation<double>> _itemAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _itemAnimationControllers = List.generate(
      widget.meals.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _itemAnimations = _itemAnimationControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    _animationController.forward();

    for (int i = 0; i < _itemAnimationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: widget.animationDelayMs * i), () {
        if (mounted) {
          _itemAnimationControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _itemAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.w, // Maximum width for each card
          childAspectRatio: 0.65,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final meal = widget.meals[index];
          return AnimatedBuilder(
            animation: _itemAnimations[index],
            builder: (context, child) {
              return Transform.scale(
                scale: _itemAnimations[index].value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - _itemAnimations[index].value)),
                  child: Opacity(
                    opacity: _itemAnimations[index].value.clamp(0.0, 1.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: GridMealCard(meal: meal, onFavoriteTap: () {}),
                    ),
                  ),
                ),
              );
            },
          );
        }, childCount: widget.meals.length),
      ),
    );
  }
}
