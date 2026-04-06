import 'package:dio/dio.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/data/data.dart';
import 'package:mrce_test_app/core/utils/utils.dart';
import 'package:talker_flutter/talker_flutter.dart';

final class AppScope {
  AppScope({
    required this.envType,
    required this.appConfig,
    required this.apiConfig,
    required this.storageAggregator,
    required this.dio,
    required this.talker,
    required this.routeObserver,
    required this.logger,
  });

  final AppEnvType envType;
  final AppConfig appConfig;
  final ApiConfig apiConfig;
  final StorageAggregator storageAggregator;
  final Dio dio;
  final Talker talker;
  final TalkerRouteObserver routeObserver;
  final ILogger logger;
}
