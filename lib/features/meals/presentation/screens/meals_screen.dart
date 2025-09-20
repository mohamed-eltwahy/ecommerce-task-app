import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/app_icons.dart';
import 'package:ecommerce_app/core/navigation/app_navigator.dart';
import 'package:ecommerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce_app/features/meals/presentation/widgets/meals_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/injection/injection_container.dart';
import '../cubit/meals_cubit.dart';
import '../cubit/meals_state.dart';
import '../widgets/seafood_hero_section.dart';
import '../widgets/meals_loading_widget.dart';
import '../widgets/meals_error_widget.dart';
import '../widgets/meals_empty_widget.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MealsCubit>()..getMeals(),
      child: Scaffold(
        body: BlocBuilder<MealsCubit, MealsState>(
          builder: (context, state) {
            if (state is MealsLoading) {
              return const MealsLoadingWidget();
            } else if (state is MealsError) {
              return MealsErrorWidget(message: state.message);
            } else if (state is MealsLoaded) {
              if (state.meals.isEmpty) {
                return const MealsEmptyWidget();
              }

              return CustomScrollView(
                slivers: [
                  const SeafoodHeroSection(),
                  MealsListSection(meals: state.meals),
                ],
              );
            }

            return const Center(child: Text('Press the button to load meals'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            sl<AppNavigator>().push(screen: const CartScreen());
          },
          shape: const CircleBorder(),
          child: Image.asset(
            AppIcons.basket,
            color: AppColors.primary,
            width: 25.w,
            height: 25.h,
          ),
        ),
      ),
    );
  }
}
