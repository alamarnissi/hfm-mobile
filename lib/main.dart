import 'package:tiwee/src/core/injectable/app_environment.dart';
import 'package:tiwee/src/core/injectable/injection.dart';
import 'package:tiwee/src/routes/appRoutes.dart';
import 'package:tiwee/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiwee/presentation/screens/splash/splash_screen.dart';

export 'package:tiwee/src/core/injectable/app_environment.dart';
export 'package:tiwee/src/core/injectable/injection.dart';
export 'package:tiwee/src/routes/routes.dart';
export 'package:tiwee/src/routes/appRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize storage

  configureTiweeModuleMicroDependencies(TiweeAppEnvironment.prod);
  configureTiweeDependencies(TiweeAppEnvironment.prod);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff1a1726)
  ));
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);


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
