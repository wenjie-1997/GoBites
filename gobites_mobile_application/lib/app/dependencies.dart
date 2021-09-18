import 'package:get_it/get_it.dart';
import 'package:gobites/models/user.dart';
import 'package:gobites/screens/customer_cart/customer_cart_viewmodel.dart';
import 'package:gobites/screens/customer_profile/customer_profile_viewmodel.dart';
import 'package:gobites/screens/customer_restaurant_list/customer_restaurant_list_viewmodel.dart';
import 'package:gobites/screens/customer_restaurant_menu/customer_restaurant_menu_viewmodel.dart';
import 'package:gobites/screens/login/login_viewmodel.dart';
import 'package:gobites/screens/register/register_viewmodel.dart';
import 'package:gobites/screens/restaurant_feedback/restaurant_feedback_viewmodel.dart';
import 'package:gobites/screens/restaurant_menu/restaurant_menu_viewmodel.dart';
import 'package:gobites/screens/restaurant_order/restaurant_order_viewmodel.dart';
import 'package:gobites/screens/restaurant_profile/restaurant_profile_viewmodel.dart';
import 'package:gobites/services/cart/cart_service.dart';
import 'package:gobites/services/cart/cart_service_rest.dart';
import 'package:gobites/services/feedback/feecback_service.dart';
import 'package:gobites/services/feedback/feedback_service_rest.dart';
import 'package:gobites/services/menu/menu_service.dart';
import 'package:gobites/services/menu/menu_service_rest.dart';

import 'package:gobites/services/customer/customer_service.dart';
import 'package:gobites/services/customer/customer_service_rest.dart';
import 'package:gobites/services/order/order_service.dart';
import 'package:gobites/services/order/order_service_rest.dart';
import 'package:gobites/services/register/register_service.dart';
import 'package:gobites/services/register/register_service_rest.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';
import 'package:gobites/services/restaurant/restaurant_service_rest.dart';

import '../services/rest.dart';

import '../services/auth/auth_service.dart';

import '../services/auth/auth_service_rest.dart';

GetIt dependency = GetIt.instance;
User user;

void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
    () => RestService(baseUrl: 'http://192.168.1.105:3000'),
  );

  dependency.registerLazySingleton<AuthService>(() => AuthServiceRest());
  dependency.registerLazySingleton<RegisterSevice>(() => RegisterServiceRest());
  dependency
      .registerLazySingleton<RestaurantService>(() => RestaurantServiceRest());
  dependency.registerLazySingleton<MenuService>(() => MenuServiceRest());
  dependency
      .registerLazySingleton<CustomerService>(() => CustomerServiceRest());
  dependency.registerLazySingleton<OrderService>(() => OrderServiceRest());
  dependency
      .registerLazySingleton<FeedbackService>(() => FeedbackServiceRest());
  dependency
      .registerLazySingleton<CartService>(() => CartServiceRest());

  // Viewmodels
  dependency.registerLazySingleton(() => LoginViewmodel());
  dependency.registerLazySingleton(() => RegisterViewmodel());
  dependency.registerLazySingleton(() => RestProfileViewmodel());
  dependency.registerLazySingleton(() => RestaurantMenuViewmodel());
  dependency.registerLazySingleton(() => CustProfileViewmodel());
  dependency.registerLazySingleton(() => RestaurantOrderViewmodel());
  dependency.registerLazySingleton(() => RestaurantFeedbackViewmodel());
  dependency.registerLazySingleton(() => CustomerRestaurantListViewmodel());
  dependency.registerLazySingleton(() => CustomerRestaurantMenuViewmodel());
  dependency.registerLazySingleton(() => CustomerCartViewmodel());
}
