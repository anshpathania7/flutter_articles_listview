import 'package:flutter_articles_listview/data/models/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
}
