// screens/recipe_list_screen.dart
import 'package:flutter/material.dart';
import 'package:recipe_book/data/sample_recipes.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/screens/recipe_detial_screen.dart';
import 'package:recipe_book/widgets/recipe/recipe_card.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Recipe> recipes = SampleData.featuredRecipes;

    return Scaffold(
      appBar: AppBar(title: const Text('All Recipes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: recipes.isEmpty
            ? const Center(child: Text('No recipes available.'))
            : ListView.separated(
                itemCount: recipes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return ResponsiveRecipeCard(
                    recipe: recipe,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                    isFavorite: SampleData.isFavorite(recipe),
                    onFavorite: () {
                      SampleData.toggleFavorite(recipe);
                      (context as Element).markNeedsBuild();
                    },
                  );
                },
              ),
      ),
    );
  }
}
