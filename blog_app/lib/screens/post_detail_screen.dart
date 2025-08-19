import 'package:blog_app/providers/comment_provider.dart';
import 'package:blog_app/screens/user_profile_screen.dart';
import 'package:blog_app/widgets/comment_card.dart';
import 'package:blog_app/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/providers/user_provider.dart';

class PostDetailScreen extends ConsumerWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider(post.userId));

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author info (same as card)
            userAsyncValue.when(
              data: (user) => UserCard(
                user: user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AuthorDetailScreen(user: user),
                    ),
                  );
                },
              ),
              loading: () => const ListTile(
                leading: CircleAvatar(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                title: Text("Loading author..."),
              ),
              error: (error, _) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.onSurfaceVariant,
                  child: Icon(Icons.person, color: colorScheme.primary),
                ),
                title: Text("Unknown Author"),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              post.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 16),

            // Body (larger and more spacing)
            Text(
              post.body,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            // Metadata footer
            Row(
              children: [
                Icon(
                  Icons.article,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  "Post #${post.id}",
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.person,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  "User ${post.userId}",
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Comments",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ref
                .watch(commentsProvider(post.id))
                .when(
                  data: (comments) => Column(
                    children: comments
                        .map((c) => CommentCard(comment: c))
                        .toList(),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text("Failed to load comments: $e"),
                ),
          ],
        ),
      ),
    );
  }
}
