import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/data/data.dart';
import 'package:flutter_app_template/core/utils/utils.dart';
import 'package:flutter_app_template/di/di.dart';
import 'package:flutter_app_template/features/auth/data/data.dart';
import 'package:flutter_app_template/features/auth/domain/domain.dart';
import 'package:flutter_app_template/features/auth/presentation/presentation.dart';
import 'package:flutter_app_template/features/settings/data/data.dart';
import 'package:flutter_app_template/features/settings/domain/domain.dart';
import 'package:flutter_app_template/features/settings/presentation/presentation.dart';
import 'package:flutter_app_template/features/theme_editor/data/data.dart';
import 'package:flutter_app_template/features/theme_editor/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AppProvidersWrapper extends StatelessWidget {
  const AppProvidersWrapper({
    required this.appScope,
    required this.child,
    super.key,
  });

  final AppScope appScope;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final IAppEnvPreset envPreset = AppEnvPresetsFactory.create(
      appScope: appScope,
    );

    return MultiProvider(
      providers: [
        Provider<AppScope>(create: (context) => appScope),
        Provider<ILogger>(create: (context) => appScope.logger),
        Provider<IHttpClient>(
          create: (context) =>
              DioHttpClient(dio: appScope.dio, apiConfig: appScope.apiConfig),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ISettingsRepo>(
            create: (context) => envPreset.createSettingsRepo(),
          ),
          RepositoryProvider<IThemeEditorRepo>(
            create: (context) => envPreset.createThemeEditorRepo(),
          ),
          RepositoryProvider<ISessionCacheRepo>(
            create: (context) {
              final cacheRepo = LocalSessionCacheRepo(
                storage: appScope.storageAggregator.secureStorage,
              );
              // TODO: uncomment if needed
              // appScope.dio.interceptors.add(
              //   JWTInterceptor(sessionCacheRepo: cacheRepo),
              // );
              return cacheRepo;
            },
          ),
        ],
        child: _InteractorProviders(child: _BlocProviders(child: child)),
      ),
    );
  }
}

class _InteractorProviders extends StatelessWidget {
  const _InteractorProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthInteractor>(
          lazy: false,
          create: (context) => AuthInteractor(),
        ),
        RepositoryProvider<SettingsInteractor>(
          lazy: false,
          create: (context) =>
              SettingsInteractor(settingsRepo: context.read<ISettingsRepo>()),
        ),
        RepositoryProvider<ThemeEditorInteractor>(
          lazy: false,
          create: (context) => ThemeEditorInteractor(
            themeEditorRepo: context.read<IThemeEditorRepo>(),
          ),
        ),
      ],
      child: child,
    );
  }
}

class _BlocProviders extends StatelessWidget {
  const _BlocProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appScope = context.read<AppScope>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            authInteractor: context.read<AuthInteractor>(),
            logger: appScope.logger,
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SettingsCubit(
            settingsInteractor: context.read<SettingsInteractor>(),
            themeConstructorInteractor: context.read<ThemeEditorInteractor>(),
            logger: appScope.logger,
          ),
        ),
      ],
      child: child,
    );
  }
}
