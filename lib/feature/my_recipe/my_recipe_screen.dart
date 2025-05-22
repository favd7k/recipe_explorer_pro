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
      final myRecipe = provider.recipes.where((recipe) => recipe.isItMine).toList();

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
                  Spacer(),
                  Text(
                    "My Recipe",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: const Icon(Icons.add_box_outlined, size: 28),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.addRecipe)),
                ],
              ),
              Expanded(
                child: myRecipe.isEmpty
                    ? EmptyState(isFavorite: false)
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        itemCount: myRecipe.length,
                        itemBuilder: (context, index) {
                          final recipe = myRecipe[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewRecipeScreen(recipe: recipe),
                                ),
                              );
                            },
                            child: RecipeItem(recipe: recipe),
                          );
                        },
                      ),
              ),
            ],
          )),
        ),
      );
    });
  }
}