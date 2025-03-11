
import 'package:Tiwee/src/features/home/presentation/controllers/home_binding.dart';
import 'package:Tiwee/src/features/home/presentation/pages/home_view.dart';
import 'package:Tiwee/src/features/splash/presentation/controllers/splash_binding.dart';
import 'package:Tiwee/src/features/splash/presentation/pages/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'routes.dart';

class AppRouts {
  static Transition transition = Transition.fadeIn;
  static Duration transitionDuration = const Duration(milliseconds: 300);
  static GetPage pageNotFound =
      GetPage(name: '/notfound', page: () => const Text("data"));

  static appRoutes() => <GetPage<dynamic>>[
        GetPage(
          name: Routs.splashRoute,
          page: () => const SplashPage(),
          binding: SplashBinding(),
          transition: transition,
          transitionDuration: transitionDuration,
        ),
    GetPage(
          name: Routs.homeRoute,
          page: () => const HomePage(),
          binding: HomeBinding(),
          transition: transition,
          transitionDuration: transitionDuration,
        ),
         ];

}
