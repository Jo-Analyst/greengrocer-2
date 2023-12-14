import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/view/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/spash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PageRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PageRoutes.signinRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: PageRoutes.signupRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PageRoutes.baseScreen,
      page: () => const BaseScreen(),
    ),
  ];
}

abstract class PageRoutes {
  static const String splashRoute = "/splash";
  static const String signinRoute = "/signin";
  static const String signupRoute = "/signup";
  static const String baseScreen = "/";
}
