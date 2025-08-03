import 'package:flutter/material.dart';
import 'package:recipe_book/data/sample_recipes.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/screens/recipe_detial_screen.dart';
import 'package:recipe_book/widgets/recipe/recipe_card.dart';

class ResponsiveRecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final int maxItems;
  final void Function(Recipe)? onFavorite;
  final bool Function(Recipe)? isFavorite;

  const ResponsiveRecipeGrid({
    super.key,
    required this.recipes,
    this.maxItems = 6,
    this.isFavorite,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final displayRecipes = recipes.take(maxItems).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;

        if (constraints.maxWidth >= 900) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          itemCount: displayRecipes.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemBuilder: (context, index) {
            final recipe = displayRecipes[index];
            return ResponsiveRecipeCard(
              recipe: recipe,
              onTap: () {
                SampleData.addToRecentlyViewed(recipe);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailScreen(recipe: recipe),
                  ),
                );
              },
              onFavorite: () => onFavorite?.call(recipe),
              isFavorite: isFavorite?.call(recipe) ?? false,
            );
          },
        );
      },
    );
  }
}
