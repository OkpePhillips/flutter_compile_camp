import 'package:blog_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Preferences")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: themeMode == AppThemeMode.dark,
            onChanged: (value) {
              ref.read(themeProvider.notifier).state = value
                  ? AppThemeMode.dark
                  : AppThemeMode.light;
            },
          ),
        ],
      ),
    );
  }
}
