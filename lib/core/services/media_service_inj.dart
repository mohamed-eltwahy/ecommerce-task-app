
import 'package:ecommerce_app/core/services/media_service/media_service_impl.dart';
import 'package:ecommerce_app/core/services/media_service/media_services.dart';
import 'package:get_it/get_it.dart';

void initMediaServiceInjection(GetIt sl) {
  sl.registerLazySingleton<MediaService>(() => MediaServiceImpl());
}