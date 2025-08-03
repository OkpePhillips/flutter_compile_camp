import 'package:flutter/material.dart';
import 'package:recipe_book/data/sample_recipes.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/screens/recipe_detial_screen.dart';
import 'package:recipe_book/widgets/recipe/recipe_card.dart';
import 'package:recipe_book/widgets/search/search_bar.dart';

class RecipeListScreen extends StatefulWidget {
  final bool startSearch;
  const RecipeListScreen({super.key, this.startSearch = false});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Recipe> _allRecipes;
  late List<Recipe> _filteredRecipes;
  late String _title;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    _allRecipes = SampleData.allRecipes;
    _title = 'All Recipes';
    _filteredRecipes = _allRecipes;

    if (widget.startSearch) {
      Future.delayed(Duration.zero, () {
        showSearch(context: context, delegate: RecipeSearchDelegate());
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String? recipeType =
        ModalRoute.of(context)?.settings.arguments as String?;

    if (recipeType == 'recent') {
      _allRecipes = SampleData.recentlyViewed;
      _title = 'Recently Viewed';
    } else if (recipeType == 'featured') {
      _allRecipes = SampleData.featuredRecipes;
      _title = 'Featured Recipes';
    } else {
      _allRecipes = SampleData.allRecipes;
      _title = 'All Recipes';
    }

    _filteredRecipes = _allRecipes;
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredRecipes = _allRecipes.where((recipe) {
        return recipe.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _filteredRecipes.isEmpty
                  ? const Center(child: Text('No recipes found.'))
                  : ListView.separated(
                      itemCount: _filteredRecipes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final recipe = _filteredRecipes[index];
                        return ResponsiveRecipeCard(
                          recipe: recipe,
                          onTap: () {
                            SampleData.addToRecentlyViewed(recipe);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecipeDetailScreen(recipe: recipe),
                              ),
                            );
                          },
                          isFavorite: SampleData.isFavorite(recipe),
                          onFavorite: () {
                            SampleData.toggleFavorite(recipe);
                            setState(() {});
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
