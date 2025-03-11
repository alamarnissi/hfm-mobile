import 'package:Tiwee/src/core/injectable/app_environment.dart';
import 'package:Tiwee/src/core/injectable/injection.dart';
import 'package:Tiwee/src/routes/appRoutes.dart';
import 'package:Tiwee/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Tiwee/presentation/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies(AppEnvironment.prod);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff1a1726)
  ));



      runApp(ProviderScope(
        child: GetMaterialApp(
          themeMode: ThemeMode.system,
          getPages: AppRouts.appRoutes(),
          initialRoute:Routs.splashRoute ,
          title: "Tiwee",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(textTheme: GoogleFonts.soraTextTheme(),
          scaffoldBackgroundColor: Color(0xff1a1726),),
        // home:  MyApp(),

      ),

      ));
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
