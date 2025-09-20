import 'package:ecommerce_app/core/services/cart_service.dart';
import 'package:ecommerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initCartInjection(GetIt sl) async {
  sl.registerFactory<CartCubit>(
    () => CartCubit(cartService: sl<CartService>()),
  );
}
