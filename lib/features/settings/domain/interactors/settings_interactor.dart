import 'package:mrce_test_app/features/settings/data/data.dart';

class SettingsInteractor {
  SettingsInteractor({
    required ISettingsRepo settingsRepo,
    // required IUserCacheRepo userCacheRepo,
    // required IUserRepo userRepo,
  }) : _settingsRepo = settingsRepo;
  //  _userCacheRepo = userCacheRepo,
  //  _userRepo = userRepo;

  final ISettingsRepo _settingsRepo;
  // final IUserCacheRepo _userCacheRepo;
  // final IUserRepo _userRepo;

  Future<bool> changeLanguage({required String newLanguageCode}) async {
    final changeLanguageSuccess = await _settingsRepo.changeLanguageCode(
      newLanguageCode: newLanguageCode,
    );

    return changeLanguageSuccess;

    // if (!changeLanguageSuccess) {
    //   return false;
    // }

    // final cachedUser = await _userCacheRepo.loadUser();

    // final updatedUser = await _userRepo.updateUser(
    //   userId: cachedUser.userId,
    //   languageCode: newLanguageCode,
    // );

    // final cacheUserSuccess = await _userCacheRepo.saveUser(user: updatedUser);
    // return cacheUserSuccess;
  }

  Future<String> getCurrentLanguageCode() async {
    return await _settingsRepo.getCurrentLanguageCode();
  }

  Future<bool> changeThemeMode({required String newThemeCode}) async {
    final changeThemeSuccess = await _settingsRepo.changeThemeMode(
      newThemeCode: newThemeCode,
    );

    return changeThemeSuccess;
  }

  Future<String> getCurrentThemeMode() async {
    return await _settingsRepo.getCurrentThemeMode();
  }
}
