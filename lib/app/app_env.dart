enum AppEnv {
  /// Dev (mock environment)
  dev('dev.env'),

  /// Stage (hybrid: network + mocks)
  stage('stage.env'),

  /// Production
  prod('prod.env');

  const AppEnv(this.fileName);

  /// Corresponding filename for environment configuration.
  final String fileName;
}
