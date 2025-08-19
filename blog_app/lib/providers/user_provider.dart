// AsyncNotifier for a single user (using family pattern)
import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAsyncNotifier extends FamilyAsyncNotifier<User, int> {
  @override
  Future<User> build(int userId) async {
    final response = await ModernJSONPlaceholderService.getUser(userId);

    return switch (response) {
      ApiSuccess<User>(data: final user) => () {
        return user;
      }(),

      ApiError<User>(message: final message, type: final type) => () {
        throw switch (type) {
          NetworkErrorType.notFound => Exception('User #$userId not found'),
          NetworkErrorType.noConnection => Exception('No internet connection'),
          _ => Exception('Failed to load user: $message'),
        };
      }(),
    };
  }
}

// Family provider for individual users
final userProvider = AsyncNotifierProvider.family<UserAsyncNotifier, User, int>(
  () {
    return UserAsyncNotifier();
  },
);

// All users provider
class UsersAsyncNotifier extends AsyncNotifier<List<User>> {
  @override
  Future<List<User>> build() async {
    final response = await ModernJSONPlaceholderService.getUsers();

    return switch (response) {
      ApiSuccess<List<User>>(data: final users) => () {
        return users;
      }(),

      ApiError<List<User>>(message: final message) => () {
        throw Exception('Failed to load users: $message');
      }(),
    };
  }
}

final usersProvider = AsyncNotifierProvider<UsersAsyncNotifier, List<User>>(() {
  return UsersAsyncNotifier();
});
