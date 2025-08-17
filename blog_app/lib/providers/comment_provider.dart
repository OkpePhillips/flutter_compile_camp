import 'package:blog_app/models/comment.dart';
import 'package:blog_app/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsAsyncNotifier extends FamilyAsyncNotifier<List<Comment>, int> {
  @override
  Future<List<Comment>> build(int postId) async {
    final response = await ModernJSONPlaceholderService.getCommentsByPost(
      postId,
    );

    return switch (response) {
      ApiSuccess<List<Comment>>(data: final comments) => comments,
      ApiError<List<Comment>>(message: final message) => throw Exception(
        'Failed to load comments: $message',
      ),
    };
  }
}

final commentsProvider =
    AsyncNotifierProvider.family<CommentsAsyncNotifier, List<Comment>, int>(
      () => CommentsAsyncNotifier(),
    );
