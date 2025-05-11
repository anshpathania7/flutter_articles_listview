import 'package:flutter/foundation.dart';
import 'package:flutter_articles_listview/data/models/post_model.dart';
import 'package:flutter_articles_listview/domain/repositories/posts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsProvider with ChangeNotifier {
  final PostRepository postRepository;

  PostsProvider({required this.postRepository});

  List<PostModel> _posts = [];
  List<PostModel> _filteredPosts = [];
  List<String> _favouritePostsId = [];
  bool _isLoading = false;
  String? _error;

  List<PostModel> get posts => _posts;
  List<PostModel> get filteredPosts => _filteredPosts;
  List<String> get favouritePostsId => _favouritePostsId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void addToFavourite({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentFavourites = prefs.getStringList('favouritePostsId') ?? [];
    final List<String> updatedFavourites = List<String>.from(currentFavourites)
      ..add(id);
    await prefs.setStringList('favouritePostsId', updatedFavourites);
    _favouritePostsId = updatedFavourites;
    notifyListeners();
  }

  void removeFromFavourite({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentFavourites = prefs.getStringList('favouritePostsId') ?? [];
    currentFavourites.remove(id);
    final List<String> updatedFavourites = List<String>.from(currentFavourites);
    await prefs.setStringList('favouritePostsId', updatedFavourites);
    _favouritePostsId = updatedFavourites;
    notifyListeners();
  }

  void filterByKeyword(String key) {
    _filteredPosts =
        _posts
            .where(
              (post) => post.body!.contains(key) || post.title!.contains(key),
            )
            .toList();
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _posts = await postRepository.getPosts();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _favouritePostsId = prefs.getStringList('favouritePostsId') ?? [];
      _filteredPosts = _posts;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
