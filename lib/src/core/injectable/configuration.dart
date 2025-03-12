import 'package:injectable/injectable.dart';

import 'app_environment.dart';

abstract class Configuration {
  String get name;

  String get getBaseUrl;

}

@LazySingleton(as: Configuration, env: [TiweeAppEnvironment.dev])
class DevConfiguration implements Configuration {
  @override
  String get getBaseUrl => '#';

  @override
  String get name => 'development';

}

@LazySingleton(as: Configuration, env: [TiweeAppEnvironment.staging])
class StagingConfiguration implements Configuration {
  @override
  String get getBaseUrl => '#';

  @override
  String get name => 'staging';


}

@LazySingleton(as: Configuration, env: [TiweeAppEnvironment.prod])
class ProductionConfiguration implements Configuration {
  @override
  String get getBaseUrl => '#';

  @override
  String get name => 'production';
  
}