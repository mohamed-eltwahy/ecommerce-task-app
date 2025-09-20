import '../entities/meal_entity.dart';
import '../repositories/meals_repository.dart';

class GetMealsUseCase {
  final MealsRepository repository;

  GetMealsUseCase({required this.repository});

  Future<List<MealEntity>> call() async {
    return await repository.getMeals();
  }
}
