import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/data/data.dart';
import 'package:mrce_test_app/core/utils/utils.dart';
import 'package:mrce_test_app/di/di.dart';
import 'package:mrce_test_app/features/geocode_caching/data/data.dart';
import 'package:mrce_test_app/features/map/data/data.dart';
import 'package:mrce_test_app/features/map/domain/domain.dart';
import 'package:mrce_test_app/features/map/presentation/presentation.dart';
import 'package:mrce_test_app/features/route_builder/data/data.dart';
import 'package:mrce_test_app/features/route_builder/domain/domain.dart';
import 'package:mrce_test_app/features/route_builder/presentation/presentation.dart';
import 'package:mrce_test_app/features/saved_addresses/data/data.dart';
import 'package:mrce_test_app/features/saved_addresses/domain/domain.dart';
import 'package:mrce_test_app/features/saved_addresses/presentation/presentation.dart';
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
        Provider<IConnectivityRepo>(
          create: (context) => ConnectivityPlusRepo(),
        ),
        Provider<IHttpClient>(
          create: (context) =>
              DioHttpClient(dio: appScope.dio, apiConfig: appScope.apiConfig),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ISavedAddressesRepo>(
            create: (context) => envPreset.createSavedAddressesRepo(),
          ),
          RepositoryProvider<IGeocodeRepo>(
            create: (context) => envPreset.createGeocodeRepo(),
          ),
          RepositoryProvider<ICachedGeocodeRepo>(
            create: (context) => envPreset.createCachedGeocodeRepo(),
          ),
          RepositoryProvider<IRouteRepo>(
            create: (context) => envPreset.createRouteRepo(),
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
        RepositoryProvider<SavedAddressesInteractor>(
          lazy: false,
          create: (context) => SavedAddressesInteractor(
            savedAddressesRepo: context.read<ISavedAddressesRepo>(),
            logger: context.read<ILogger>(),
          ),
        ),
        RepositoryProvider<GeocodeInteractor>(
          lazy: false,
          create: (context) => GeocodeInteractor(
            geocodeRepo: context.read<IGeocodeRepo>(),
            cachedGeocodeRepo: context.read<ICachedGeocodeRepo>(),
            logger: context.read<ILogger>(),
          ),
        ),
        RepositoryProvider<RouteInteractor>(
          lazy: false,
          create: (context) => RouteInteractor(
            routeRepo: context.read<IRouteRepo>(),
            logger: context.read<ILogger>(),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapCubit(
            connectivityRepo: context.read<IConnectivityRepo>(),
            logger: context.read<ILogger>(),
          ),
        ),
        BlocProvider(
          create: (context) => GeocodeBloc(
            geocodeInteractor: context.read<GeocodeInteractor>(),
            logger: context.read<ILogger>(),
          ),
        ),
        BlocProvider(
          create: (context) => SavedAddressesCubit(
            savedAddressesInteractor: context.read<SavedAddressesInteractor>(),
            logger: context.read<ILogger>(),
          ),
        ),
        BlocProvider(
          create: (context) => RouteBuilderCubit(
            routeInteractor: context.read<RouteInteractor>(),
            logger: context.read<ILogger>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
