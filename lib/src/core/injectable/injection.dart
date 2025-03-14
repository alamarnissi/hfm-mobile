import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// import 'injection.module.dart';
import 'injection.config.dart';

final GetIt tiweeGetIt = GetIt.instance;

@InjectableInit.microPackage()
void configureTiweeModuleMicroDependencies(String env) => tiweeGetIt.init(environment: env);

@InjectableInit()
void configureTiweeDependencies(String env) => tiweeGetIt.init(environment: env);


Future<void> resetInjection() async {
  await tiweeGetIt.reset();
}