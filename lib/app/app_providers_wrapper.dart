import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/data/data.dart';
import 'package:mrce_test_app/core/utils/utils.dart';
import 'package:mrce_test_app/di/di.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';
import 'package:mrce_test_app/features/settings/data/data.dart';
import 'package:mrce_test_app/features/settings/domain/domain.dart';
import 'package:mrce_test_app/features/settings/presentation/presentation.dart';
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
          RepositoryProvider<ISavedAddressesRepo>(
            create: (context) => envPreset.createSavedAddressesRepo(),
          ),
          RepositoryProvider<IGeocodeRepo>(
            create: (context) => envPreset.createGeocodeRepo(),
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
        RepositoryProvider<SettingsInteractor>(
          lazy: false,
          create: (context) =>
              SettingsInteractor(settingsRepo: context.read<ISettingsRepo>()),
        ),
        RepositoryProvider<SavedAddressesInteractor>(
          lazy: false,
          create: (context) => SavedAddressesInteractor(
            savedAddressesRepo: context.read<ISavedAddressesRepo>(),
          ),
        ),
        RepositoryProvider<GeocodeInteractor>(
          lazy: false,
          create: (context) =>
              GeocodeInteractor(geocodeRepo: context.read<IGeocodeRepo>()),
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
          create: (context) => SettingsCubit(
            settingsInteractor: context.read<SettingsInteractor>(),
            logger: appScope.logger,
          )..restoreSettings(),
        ),
      ],
      child: child,
    );
  }
}
