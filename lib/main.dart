import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/runners/app_runner.dart';

/// flutter run --dart-define=APP_ENV_TYPE=prod

void main() {
  const envString = String.fromEnvironment('APP_ENV_TYPE', defaultValue: 'dev');

  final AppEnvType env = switch (envString) {
    'dev' => AppEnvType.dev,
    'stage' => AppEnvType.stage,

    _ => throw Exception('Unknown env type: $envString'),
  };

  AppRunner(env).run();
}
