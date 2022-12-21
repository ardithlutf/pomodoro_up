import 'package:get_it/get_it.dart';
import 'package:pomodoro_up/providers/database.dart';

GetIt locator = GetIt.instance;

setupDatabase() {
  locator.registerSingleton<AppDb>(AppDb());
}
