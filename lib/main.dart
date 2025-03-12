import 'package:tiwee/src/core/injectable/app_environment.dart';
import 'package:tiwee/src/core/injectable/injection.dart';
import 'package:tiwee/src/routes/appRoutes.dart';
import 'package:tiwee/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiwee/presentation/screens/splash/splash_screen.dart';

export 'package:tiwee/src/core/injectable/app_environment.dart';
export 'package:tiwee/src/core/injectable/injection.dart';
export 'package:tiwee/src/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureTiweeDependencies(TiweeAppEnvironment.prod);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff1a1726)
  ));



      runApp(ProviderScope(
        child: GetMaterialApp(
          themeMode: ThemeMode.system,
          getPages: TiweeAppRouts.appRoutes(),
          initialRoute:TiweeRouts.splashRoute ,
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
