import 'package:blog_app/models/user.dart';
import 'package:blog_app/providers/post_provider.dart';
import 'package:blog_app/widgets/post_card.dart';
import 'package:blog_app/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthorDetailScreen extends ConsumerWidget {
  final User user;

  const AuthorDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(user.displayName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Show author details with UserCard
            UserCard(user: user),

            const SizedBox(height: 24),
            const Text(
              "Articles by this author",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            postsAsyncValue.when(
              data: (posts) {
                final authorPosts = posts
                    .where((p) => p.userId == user.id)
                    .toList();

                if (authorPosts.isEmpty) {
                  return const Text("No posts from this author.");
                }

                // ✅ Use ModernPostCard instead of ListTile
                return Column(
                  children: authorPosts
                      .map((post) => ModernPostCard(post: post))
                      .toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text("Failed to load posts: $e"),
            ),
          ],
        ),
      ),
    );
  }
}
