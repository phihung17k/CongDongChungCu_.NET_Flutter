
import '../repository/user_repository.dart';
import 'package:get_it/get_it.dart';

class RepositoryDependencies{
  static Future setup(GetIt injector) async {
    injector.registerSingleton<UserRepository>(UserRepository());
  }
}