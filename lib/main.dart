import 'package:flutter/material.dart';
import 'package:flutter_articles_listview/domain/repositories/posts_repository.dart';
import 'package:flutter_articles_listview/provider/posts_provider.dart';
import 'package:flutter_articles_listview/screens/posts/posts_screen.dart';
import 'package:flutter_articles_listview/services/di_service.dart';
import 'package:provider/provider.dart';

void main() async {
  setupDependecyInjection();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PostsProvider(postRepository: di<PostRepository>()),
          ),
        ],

        child: PostScreen(),
      ),
    );
  }
}
