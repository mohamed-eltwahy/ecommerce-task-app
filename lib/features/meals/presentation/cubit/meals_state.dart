import '../../domain/entities/meal_entity.dart';

abstract class MealsState {}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final List<MealEntity> meals;

  MealsLoaded({required this.meals});
}

class MealsError extends MealsState {
  final String message;

  MealsError({required this.message});
}
