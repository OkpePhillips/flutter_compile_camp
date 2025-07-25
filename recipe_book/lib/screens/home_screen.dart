import 'package:flutter/material.dart';
import 'package:recipe_book/data/sample_recipes.dart';
import 'package:recipe_book/screens/recipe_detial_screen.dart';
import 'package:recipe_book/screens/recipe_list_screen.dart';
import 'package:recipe_book/utils/responsive_breakpoints.dart';
import 'package:recipe_book/widgets/recipe/recipe_card.dart';
import 'package:recipe_book/widgets/recipe/recipe_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            SizedBox(height: 32),
            _buildFeaturedRecipes(context),
            SizedBox(height: 32),
            _buildQuickCategories(context),
            SizedBox(height: 32),
            _buildRecentlyViewed(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Recipe Book'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => _showSearch(context),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () => _navigateToShoppingList(context),
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: ResponsiveBreakpoints.isMobile(context) ? 200 : 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[400]!, Colors.deepOrange[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Recipe Book',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Discover amazing recipes for every occasion',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _exploreRecipes(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange[600],
              ),
              child: Text('Explore Recipes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Recipes',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => _viewAllRecipes(context, recent: false),
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(height: 16),
        ResponsiveRecipeGrid(
          recipes: SampleData.featuredRecipes,
          maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 6,
        ),
      ],
    );
  }

  Widget _buildQuickCategories(BuildContext context) {
    final categories = [
      'Breakfast',
      'Lunch',
      'Dinner',
      'Vegan',
      'Dessert',
      'Snacks',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;

        if (isSmallScreen) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                return ActionChip(
                  label: Text(category),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Filter by: $category')),
                    );
                  },
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(color: Colors.black87),
                );
              }).toList(),
            ),
          );
        } else {
          return SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                return ActionChip(
                  label: Text(category),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Filter by: $category')),
                    );
                  },
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(color: Colors.black87),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildRecentlyViewed(BuildContext context) {
    final recentlyViewed = SampleData.recentlyViewed;

    if (recentlyViewed.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recently Viewed',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  _viewAllRecipes(context, recent: true);
                },
                child: Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: recentlyViewed.length,
            separatorBuilder: (_, __) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              final recipe = recentlyViewed[index];
              return SizedBox(
                width: 200,
                child: ResponsiveRecipeCard(
                  recipe: recipe,
                  isFavorite: false,
                  onTap: () {
                    SampleData.addToRecentlyViewed(recipe);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailScreen(recipe: recipe),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper methods
  void _showSearch(BuildContext context) {}

  void _navigateToShoppingList(BuildContext context) {
    // Navigate to shopping list
  }

  void _exploreRecipes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RecipeListScreen()),
    );
  }

  void _viewAllRecipes(BuildContext context, {required bool recent}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RecipeListScreen(),
        settings: RouteSettings(arguments: recent ? 'recent' : 'featured'),
      ),
    );
  }
}
