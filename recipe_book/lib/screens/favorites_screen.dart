// screens/favorite_screen.dart
import 'package:flutter/material.dart';
import 'package:recipe_book/data/sample_recipes.dart';
import 'package:recipe_book/utils/responsive_breakpoints.dart';
import 'package:recipe_book/widgets/recipe/recipe_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = SampleData.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: favorites.isEmpty
            ? Center(
                child: Text(
                  'No favorite recipes yet.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            : ResponsiveRecipeGrid(
                recipes: favorites,
                maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 6,
              ),
      ),
    );
  }
}
