import 'package:flutter_articles_listview/domain/repositories/posts_repository.dart';

import '../../services/api_service.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiService apiService;

  PostRepositoryImpl(this.apiService);

  @override
  Future<List<PostModel>> getPosts() => apiService.fetchPosts();
}
