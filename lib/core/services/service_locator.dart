import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:readify_app/core/services/token_storage_service.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerLazySingleton<TokenStorageService>(
    () => TokenStorageService(sl<SharedPreferences>()),
  );
}