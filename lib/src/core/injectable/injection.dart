import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies(String env) => getIt.init(environment: env);

Future<void> resetInjection() async {
  await getIt.reset();
}