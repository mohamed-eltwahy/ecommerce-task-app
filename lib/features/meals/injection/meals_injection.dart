import 'package:get_it/get_it.dart';
import '../data/datasources/meals_remote_datasource.dart';
import '../data/repositories/meals_repository_impl.dart';
import '../domain/repositories/meals_repository.dart';
import '../domain/usecases/get_meals_usecase.dart';
import '../presentation/cubit/meals_cubit.dart';

final sl = GetIt.instance;

void initMeals() {
  // Cubit
  sl.registerFactory(() => MealsCubit(getMealsUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMealsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<MealsRepository>(
    () => MealsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MealsRemoteDataSource>(
    () => MealsRemoteDataSourceImpl(),
  );
}
