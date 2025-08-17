import 'package:blog_app/providers/theme_provider.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Posts App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode == AppThemeMode.light
          ? ThemeMode.light
          : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: ModernPostsScreen(),
    );
  }
}
