import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meals_repository.dart';
import '../datasources/meals_remote_datasource.dart';
import '../models/meal_model.dart';

class MealsRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remoteDataSource;

  MealsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MealEntity>> getMeals() async {
    final mealModels = await remoteDataSource.getMeals();
    return mealModels.map((model) => _mapModelToEntity(model)).toList();
  }

  MealEntity _mapModelToEntity(MealModel model) {
    return MealEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      imageUrl: model.imageUrl,
      price: model.price,
      priceBeforeDiscount: model.priceBeforeDiscount,
      options: model.options
          .map(
            (option) => MealOptionEntity(
              id: option.id,
              name: option.name,
              isRequired: option.isRequired,
              isSingle: option.isSingle,
              isPriceDetermining: option.isPriceDetermining,
              values: option.values
                  .map(
                    (value) => MealOptionValueEntity(
                      id: value.id,
                      name: value.name,
                      price: value.price,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
