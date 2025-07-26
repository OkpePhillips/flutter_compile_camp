import 'package:recipe_book/models/ingredient.dart';
import 'package:recipe_book/models/nutrition_info.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> additionalImages;
  final int cookTimeMinutes;
  final int prepTimeMinutes;
  final int servings;
  final String difficulty; // 'easy', 'medium', 'hard'
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final List<String> tags;
  final NutritionInfo nutritionInfo;
  final double rating;
  final int reviewCount;
  final String category;
  final DateTime createdAt;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.cookTimeMinutes,
    required this.prepTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.ingredients,
    required this.instructions,
    this.tags = const [],
    required this.nutritionInfo,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.category,
    required this.createdAt,
  });

  // Helper methods
  int get totalTimeMinutes => cookTimeMinutes + prepTimeMinutes;

  bool get isQuickMeal => totalTimeMinutes <= 30;

  bool get isVegetarian => tags.contains('vegetarian');

  bool get isVegan => tags.contains('vegan');

  bool get isGlutenFree => tags.contains('gluten-free');

  // Method to scale ingredients for different serving sizes
  Recipe scaleForServings(int newServings) {
    final scaleFactor = newServings / servings;
    final scaledIngredients = ingredients
        .map((ingredient) => ingredient.scale(scaleFactor))
        .toList();

    return Recipe(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      additionalImages: additionalImages,
      cookTimeMinutes: cookTimeMinutes,
      prepTimeMinutes: prepTimeMinutes,
      servings: newServings,
      difficulty: difficulty,
      ingredients: scaledIngredients,
      instructions: instructions,
      tags: tags,
      nutritionInfo: nutritionInfo.scale(scaleFactor),
      rating: rating,
      reviewCount: reviewCount,
      category: category,
      createdAt: createdAt,
    );
  }
}


