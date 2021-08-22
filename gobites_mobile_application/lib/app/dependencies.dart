import 'package:get_it/get_it.dart';
import 'package:gobites/models/user.dart';
import 'package:gobites/screens/login/login_viewmodel.dart';
import 'package:gobites/screens/register/register_viewmodel.dart';
import 'package:gobites/screens/restaurant_profile/restaurant_profile_viewmodel.dart';
import 'package:gobites/services/register/register_service.dart';
import 'package:gobites/services/register/register_service_rest.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';
import 'package:gobites/services/restaurant/restaurant_service_rest.dart';

import '../services/rest.dart';

import '../services/auth/auth_service.dart';
import '../services/counter/counter_service.dart';

import '../services/auth/auth_service_rest.dart';
import '../services/counter/counter_service_rest.dart';

GetIt dependency = GetIt.instance;
User user;

void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
    () => RestService(baseUrl: 'http://192.168.1.105:3000'),
  );

  dependency.registerLazySingleton<CounterService>(() => CounterServiceRest());
  dependency.registerLazySingleton<AuthService>(() => AuthServiceRest());
  dependency.registerLazySingleton<RegisterSevice>(() => RegisterServiceRest());
  dependency
      .registerLazySingleton<RestaurantService>(() => RestaurantServiceRest());

  // Viewmodels
  dependency.registerLazySingleton(() => LoginViewmodel());
  dependency.registerLazySingleton(() => RegisterViewmodel());
  dependency.registerLazySingleton(() => RestProfileViewmodel());
}
