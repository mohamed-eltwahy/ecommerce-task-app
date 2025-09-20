import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_meals_usecase.dart';
import 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final GetMealsUseCase getMealsUseCase;

  MealsCubit({required this.getMealsUseCase}) : super(MealsInitial());

  Future<void> getMeals() async {
    emit(MealsLoading());

    try {
      final meals = await getMealsUseCase();
      emit(MealsLoaded(meals: meals));
    } catch (e) {
      emit(MealsError(message: e.toString()));
    }
  }
}
