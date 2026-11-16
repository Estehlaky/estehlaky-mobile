// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:uuid/uuid.dart' as _i706;

import '../device_id/device_id_services.dart' as _i560;
import '../device_id/uuid.dart' as _i54;
import '../dio/auth_interceptor.dart' as _i839;
import '../dio/dio_module.dart' as _i977;
import '../session/session_invalidation_notifier.dart' as _i243;
import '../session/session_invalidation_notifier_impl.dart' as _i574;
import '../session/session_service.dart' as _i105;
import '../storage/secure_storage_service.dart' as _i666;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final storageModule = _$StorageModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i706.Uuid>(() => appModule.uuid);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.provideFlutterSecureStorage(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.refreshDio(),
      instanceName: 'refreshDio',
    );
    gh.lazySingleton<_i54.UuidGenerator>(() => const _i54.UuidGeneratorImpl());
    gh.lazySingleton<_i243.SessionInvalidationNotifier>(
      () => _i574.SessionInvalidationNotifierImpl(),
    );
    gh.lazySingleton<_i560.DeviceIdService>(
      () => _i560.DeviceIdService(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i54.UuidGenerator>(),
      ),
    );
    gh.lazySingleton<_i666.SecureStorageService>(
      () => _i666.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i105.SessionService>(
      () => _i105.SessionService(gh<_i666.SecureStorageService>()),
    );
    gh.lazySingleton<_i839.AuthInterceptor>(
      () => _i839.AuthInterceptor(
        gh<_i105.SessionService>(),
        gh<_i243.SessionInvalidationNotifier>(),
        gh<_i361.Dio>(instanceName: 'refreshDio'),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i839.AuthInterceptor>()),
    );
    return this;
  }
}

class _$AppModule extends _i54.AppModule {}

class _$StorageModule extends _i913.StorageModule {}

class _$DioModule extends _i977.DioModule {}
