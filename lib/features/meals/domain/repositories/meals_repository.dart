import '../entities/meal_entity.dart';

abstract class MealsRepository {
  Future<List<MealEntity>> getMeals();
}
