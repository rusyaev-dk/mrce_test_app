// import 'package:dio/dio.dart';
// import 'package:flutter_app_template/app/app.dart';
// import 'package:flutter_app_template/core/core.dart';

// final class AcceptLanguageInterceptor extends Interceptor {
//   AcceptLanguageInterceptor({
//     required IUserCacheRepo userCacheRepo,
//     required ILogger logger,
//   }) : _userCacheRepo = userCacheRepo,
//        _logger = logger;

//   final IUserCacheRepo _userCacheRepo;
//   final ILogger _logger;

//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     try {
//       final user = await _userCacheRepo.loadUser();
//       options.headers['Accept-Language'] = user.languageCode;
//     } on (StorageNotFoundException, StorageReadException) catch (e, st) {
//       options.headers['Accept-Language'] = AppConfig.defaultLanguageCode;
//       _logger.exception(e, st);
//     } catch (e, st) {
//       _logger.exception(e, st);
//       rethrow;
//     }

//     handler.next(options);
//   }
// }
