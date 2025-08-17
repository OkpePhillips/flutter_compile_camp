import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_app/providers/user_provider.dart';
import 'package:blog_app/providers/post_provider.dart';

class AuthorDetailScreen extends ConsumerWidget {
  final int userId;
  const AuthorDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId));
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Author Profile")),
      body: userAsync.when(
        data: (user) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile info
              Row(
                children: [
                  CircleAvatar(radius: 28, child: Text(user.name[0])),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        user.company.name,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Their articles
              const Text(
                "Articles",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              postsAsync.when(
                data: (posts) {
                  final userPosts = posts
                      .where((p) => p.userId == user.id)
                      .toList();
                  return Column(
                    children: userPosts
                        .map(
                          (p) => Card(
                            child: ListTile(
                              title: Text(p.title),
                              subtitle: Text(
                                p.body,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                // Navigate to PostDetailScreen
                              },
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text("Failed to load posts: $e"),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Failed: $e")),
      ),
    );
  }
}
