//@GeneratedMicroModule;TiweePackageModule;package:tiwee/src/core/injectable/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:dio/dio.dart' as _i361;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:tiwee/src/core/injectable/configuration.dart' as _i633;
import 'package:tiwee/src/core/injectable/injectable_module.dart' as _i324;

const String _staging = 'staging';
const String _dev = 'dev';
const String _prod = 'prod';

class TiweePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i633.Configuration>(
      () => _i633.StagingConfiguration(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i633.Configuration>(
      () => _i633.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i633.Configuration>(
      () => _i633.ProductionConfiguration(),
      registerFor: {_prod},
    );
  }
}

class _$InjectableModule extends _i324.InjectableModule {}
