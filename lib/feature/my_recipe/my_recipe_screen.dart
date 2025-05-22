import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/recipe_provider.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/theme/theme_container.dart';
import '../favorite/widget/empty_search.dart';
import '../view_recipe/view_recipe_screen.dart';

class MyRecipeScreen extends StatelessWidget {
  const MyRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(builder: (context, provider, child) {
      final myRecipes = provider.recipes.where((recipe) => recipe.isItMine).toList();

      return Scaffold(
        body: ThemeContainer(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      "My Recipes",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add_box_outlined, size: 28),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.addRecipe),
                    ),
                  ],
                ),
                Expanded(
                  child: myRecipes.isEmpty
                      ? const EmptyState(isFavorite: false)
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          itemCount: myRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = myRecipes[index];
                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    recipe.thumbnailUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(recipe.name),
                                subtitle: Text('${recipe.category} | ${recipe.area}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewRecipeScreen(recipe: recipe),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => provider.deleteRecipe(recipe.id, context),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewRecipeScreen(recipe: recipe),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}