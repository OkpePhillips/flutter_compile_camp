// screens/recipe_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:recipe_book/models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(context),
                  const SizedBox(height: 8),
                  _buildMetaInfo(),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Description'),
                  Text(recipe.description),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Ingredients'),
                  ...recipe.ingredients.map(
                    (ingredient) => Text(
                      '• ${ingredient.amount} ${ingredient.unit} ${ingredient.name}',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Instructions'),
                  ...recipe.instructions.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('${entry.key + 1}. ${entry.value}'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Nutrition Info (per serving)'),
                  _buildNutritionInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(recipe.imageUrl, fit: BoxFit.cover),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      recipe.title,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMetaInfo() {
    return Row(
      children: [
        _buildIconText(Icons.timer, '${recipe.totalTimeMinutes} min'),
        const SizedBox(width: 16),
        _buildIconText(Icons.people, '${recipe.servings} servings'),
        const SizedBox(width: 16),
        _buildIconText(Icons.leaderboard, recipe.difficulty),
      ],
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildNutritionInfo() {
    final n = recipe.nutritionInfo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Calories: ${n.calories} kcal'),
        Text('Protein: ${n.protein} g'),
        Text('Carbs: ${n.carbs} g'),
        Text('Fat: ${n.fat} g'),
        Text('Fiber: ${n.fiber} g'),
        Text('Sugar: ${n.sugar} g'),
        Text('Sodium: ${n.sodium} mg'),
      ],
    );
  }
}
