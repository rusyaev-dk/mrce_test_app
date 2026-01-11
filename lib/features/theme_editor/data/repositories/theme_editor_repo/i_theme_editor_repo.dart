import 'package:flutter_app_template/features/theme_editor/domain/domain.dart';

abstract interface class IThemeEditorRepo {
  Future<AppTheme> loadAppTheme();

  Future<bool> updateAppTheme({required AppTheme updatedAppTheme});
}
