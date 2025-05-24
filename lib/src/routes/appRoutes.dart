import 'package:tiwee/src/features/activecode/presentation/controllers/activecode_binding.dart';
import 'package:tiwee/src/features/activecode/presentation/pages/activecode_view.dart';
import 'package:tiwee/src/features/home/presentation/controllers/home_binding.dart';
import 'package:tiwee/src/features/home/presentation/pages/home_view.dart';
// import 'package:tiwee/presentation/screens/home/home_page.dart';
import 'package:tiwee/src/features/splash/presentation/controllers/splash_binding.dart';
import 'package:tiwee/src/features/splash/presentation/pages/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

class TiweeAppRouts {
  static Transition transition = Transition.fadeIn;
  static Duration transitionDuration = const Duration(milliseconds: 300);
  static GetPage pageNotFound =
      GetPage(name: '/notfound', page: () => const Text("data"));

  static appRoutes() => <GetPage<dynamic>>[
        GetPage(
          name: TiweeRouts.splashRoute,
          page: () => const SplashPage(),
          binding: SplashBinding(),
          transition: transition,
          transitionDuration: transitionDuration,
        ),
        GetPage(
          name: TiweeRouts.homeRoute,
          page: () => const HomePage(),
          binding: HomeBinding(),
          transition: transition,
          transitionDuration: transitionDuration,
        ),
        GetPage(
          name: TiweeRouts.activecodeRoute, 
          page: () => ActiveCodePage(),
          binding: ActiveCodeBinding(),
          transition: transition,
          transitionDuration: transitionDuration
          )
      ];
}
