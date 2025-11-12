import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/runners/app_runner.dart';

/// flutter run --dart-define=APP_ENV_TYPE=prod

void main() {
  const envString = String.fromEnvironment('APP_ENV_TYPE', defaultValue: 'dev');

  final AppEnvType env = switch (envString) {
    'dev' => AppEnvType.dev,
    'stage' => AppEnvType.stage,
    'prod' => AppEnvType.prod,
    _ => throw Exception('Unknown env type: $envString'),
  };

  AppRunner(env).run();
}
