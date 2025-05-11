import 'package:flutter_articles_listview/data/repositories/posts_repository.dart';
import 'package:flutter_articles_listview/domain/repositories/posts_repository.dart';
import 'package:get_it/get_it.dart';

import '../services/api_service.dart';

final di = GetIt.instance;

void setupDependecyInjection() {
  di.registerLazySingleton<ApiService>(() => ApiService());
  di.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(di<ApiService>()),
  );
}
