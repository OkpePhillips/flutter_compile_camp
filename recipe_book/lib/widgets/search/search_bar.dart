import 'package:flutter/material.dart';
import 'package:recipe_book/data/sample_recipes.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/screens/recipe_detial_screen.dart';
import 'package:recipe_book/widgets/recipe/recipe_card.dart';

class RecipeSearchDelegate extends SearchDelegate<Recipe?> {
  @override
  String get searchFieldLabel => 'Search recipes';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = SampleData.allRecipes.where((recipe) {
      return recipe.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(results, context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = SampleData.allRecipes.where((recipe) {
      return recipe.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(suggestions, context);
  }

  Widget _buildResultsList(List<Recipe> recipes, BuildContext context) {
    if (recipes.isEmpty) {
      return const Center(child: Text('No recipes found.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        return ResponsiveRecipeCard(
          recipe: recipe,
          isFavorite: SampleData.isFavorite(recipe),
          onFavorite: () {
            SampleData.toggleFavorite(recipe);
          },
          onTap: () {
            SampleData.addToRecentlyViewed(recipe);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(recipe: recipe),
              ),
            );
          },
        );
      },
    );
  }
}
