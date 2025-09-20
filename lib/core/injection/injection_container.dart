import 'package:ecommerce_app/core/navigation/navigation_inj.dart';
import 'package:ecommerce_app/core/network/network_service_inj.dart';
import 'package:ecommerce_app/core/services/media_service_inj.dart';
import 'package:ecommerce_app/core/storage/storage_inj.dart';
import 'package:ecommerce_app/features/cart/injection/cart_injection.dart';
import 'package:ecommerce_app/features/meals/injection/meals_injection.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await initStorageInjection(sl);
  initNavigationInjection(sl);
  initNetworkServiceInjection(sl);
  initMediaServiceInjection(sl);
  initMeals();
  initCartInjection(sl);
}
