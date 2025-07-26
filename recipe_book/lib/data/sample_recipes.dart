import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/models/ingredient.dart';
import 'package:recipe_book/models/nutrition_info.dart';

class SampleData {
  static final featuredRecipes = [
    Recipe(
      id: 'r1',
      title: 'Spaghetti Bolognese',
      description:
          'A hearty Italian pasta with rich meat sauce, perfect for family dinners.',
      imageUrl:
          'https://images.unsplash.com/photo-1647918515467-50668313e213?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      additionalImages: [
        'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1603052879435-fb1e2f6d2d6f?auto=format&fit=crop&w=800&q=80',
      ],
      cookTimeMinutes: 30,
      prepTimeMinutes: 15,
      servings: 4,
      difficulty: 'medium',
      ingredients: [
        Ingredient(name: 'Spaghetti', amount: 400, unit: 'g'),
        Ingredient(name: 'Ground Beef', amount: 500, unit: 'g'),
        Ingredient(name: 'Tomato Sauce', amount: 2, unit: 'cups'),
        Ingredient(name: 'Onion', amount: 1, unit: 'medium'),
        Ingredient(name: 'Garlic', amount: 2, unit: 'cloves', isOptional: true),
      ],
      instructions: [
        'Boil the spaghetti in salted water until al dente.',
        'Sauté chopped onions and garlic in a pan.',
        'Add ground beef and cook until browned.',
        'Stir in tomato sauce and simmer for 20 minutes.',
        'Serve sauce over spaghetti.',
      ],
      tags: ['Italian', 'Pasta', 'Dinner'],
      nutritionInfo: NutritionInfo(
        calories: 680,
        protein: 35.0,
        carbs: 75.0,
        fat: 28.0,
        fiber: 6.0,
        sugar: 9.0,
        sodium: 720.0,
      ),
      rating: 4.5,
      reviewCount: 125,
      category: 'Main Course',
      createdAt: DateTime(2024, 12, 1),
    ),
    Recipe(
      id: 'r2',
      title: 'Avocado Toast',
      description: 'A simple, healthy breakfast packed with good fats.',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1676106623583-e68dd66683e3?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      additionalImages: [],
      cookTimeMinutes: 0,
      prepTimeMinutes: 10,
      servings: 2,
      difficulty: 'easy',
      ingredients: [
        Ingredient(name: 'Whole Grain Bread', amount: 2, unit: 'slices'),
        Ingredient(name: 'Avocado', amount: 1, unit: 'whole'),
        Ingredient(name: 'Lemon Juice', amount: 1, unit: 'tbsp'),
        Ingredient(
          name: 'Chili Flakes',
          amount: 0.5,
          unit: 'tsp',
          isOptional: true,
        ),
      ],
      instructions: [
        'Toast the bread slices.',
        'Mash the avocado with lemon juice.',
        'Spread avocado on toast and sprinkle chili flakes.',
      ],
      tags: ['Breakfast', 'Vegan', 'Quick'],
      nutritionInfo: NutritionInfo(
        calories: 360,
        protein: 8.0,
        carbs: 27.0,
        fat: 24.0,
        fiber: 8.0,
        sugar: 1.5,
        sodium: 270.0,
      ),
      rating: 4.8,
      reviewCount: 200,
      category: 'Snack',
      createdAt: DateTime(2025, 1, 5),
    ),
    Recipe(
      id: 'r3',
      title: 'Grilled Chicken Salad',
      description: 'High-protein, fresh salad perfect for a light lunch.',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1695399566183-df3e7778e198?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      additionalImages: [
        'https://images.unsplash.com/photo-1572441710533-7f05be0f1bc4?auto=format&fit=crop&w=800&q=80',
      ],
      cookTimeMinutes: 20,
      prepTimeMinutes: 10,
      servings: 2,
      difficulty: 'medium',
      ingredients: [
        Ingredient(name: 'Chicken Breast', amount: 2, unit: 'pieces'),
        Ingredient(name: 'Lettuce', amount: 3, unit: 'cups'),
        Ingredient(name: 'Cherry Tomatoes', amount: 1, unit: 'cup'),
        Ingredient(name: 'Cucumber', amount: 0.5, unit: 'whole'),
        Ingredient(
          name: 'Salad Dressing',
          amount: 2,
          unit: 'tbsp',
          isOptional: true,
        ),
      ],
      instructions: [
        'Season and grill chicken breasts until cooked through.',
        'Chop vegetables and mix in a bowl.',
        'Slice grilled chicken and place over salad.',
        'Drizzle with dressing before serving.',
      ],
      tags: ['Healthy', 'Salad', 'Lunch'],
      nutritionInfo: NutritionInfo(
        calories: 420,
        protein: 38.0,
        carbs: 12.0,
        fat: 24.0,
        fiber: 4.0,
        sugar: 3.0,
        sodium: 580.0,
      ),
      rating: 4.7,
      reviewCount: 89,
      category: 'Salad',
      createdAt: DateTime(2025, 2, 20),
    ),
  ];

  static final recentlyViewed = [
    featuredRecipes[0],
    if (featuredRecipes.length > 1) featuredRecipes[1],
  ];

  static List<Recipe> favorites = [];

  static bool isFavorite(Recipe recipe) {
    return favorites.any((r) => r.id == recipe.id);
  }

  static void toggleFavorite(Recipe recipe) {
    final existingIndex = favorites.indexWhere((r) => r.id == recipe.id);
    if (existingIndex >= 0) {
      favorites.removeAt(existingIndex);
    } else {
      favorites.add(recipe);
    }
  }
}
