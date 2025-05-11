import 'package:flutter/material.dart';
import 'package:flutter_articles_listview/provider/posts_provider.dart';
import 'package:flutter_articles_listview/screens/posts/posts_detailed_screen.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PostsProvider>().fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts'), backgroundColor: Colors.blue),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Consumer<PostsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text('Error: ${provider.error}'));
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => provider.filterByKeyword(value),
                    decoration: InputDecoration(
                      label: Text("Search "),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(child: Text("All")),
                    Tab(child: Text("Favourite")),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      provider.filteredPosts.isEmpty
                          ? Center(child: Text("Oops Nothing Found"))
                          : Expanded(
                            child: RefreshIndicator(
                              child: ListView.builder(
                                itemCount: provider.filteredPosts.length,
                                itemBuilder: (context, index) {
                                  final post = provider.filteredPosts[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: ListTile(
                                        onTap:
                                            () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (contxet) =>
                                                        PostDetailedScreen(
                                                          post: post,
                                                        ),
                                              ),
                                            ),
                                        title: Text(post.title ?? "N.A"),
                                        subtitle: Text(post.body ?? "N.A"),
                                        trailing: IconButton(
                                          onPressed: () {
                                            provider.favouritePostsId.contains(
                                                  post.id.toString(),
                                                )
                                                ? provider.removeFromFavourite(
                                                  id: post.id.toString(),
                                                )
                                                : provider.addToFavourite(
                                                  id: post.id.toString(),
                                                );
                                          },
                                          icon: Icon(
                                            Icons.favorite,

                                            color:
                                                provider.favouritePostsId
                                                        .contains(
                                                          post.id.toString(),
                                                        )
                                                    ? Colors.red
                                                    : Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              onRefresh: () => provider.fetchPosts(),
                            ),
                          ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: provider.favouritePostsId.length,
                          itemBuilder: (context, index) {
                            final post = provider.posts.firstWhere(
                              (post) =>
                                  post.id.toString() ==
                                  provider.favouritePostsId[index],
                            );
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (contxet) => PostDetailedScreen(
                                                post: post,
                                              ),
                                        ),
                                      ),
                                  title: Text(post.title ?? "N.A"),
                                  subtitle: Text(post.body ?? "N.A"),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
