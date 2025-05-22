import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_explorer_pro/data/models/recipe_model.dart';
import 'package:recipe_explorer_pro/providers/recipe_provider.dart';
import '../../../utils/http/url_launcher_service.dart';
import 'display_button.dart';

class RecipeButtons extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeButtons({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);

    void _showEditDialog() {
      recipeProvider.initializeEditControllers(recipe);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Edit Recipe'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: recipeProvider.nameController,
                  decoration: const InputDecoration(labelText: 'Recipe Name'),
                ),
                TextField(
                  controller: recipeProvider.categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: recipeProvider.areaController,
                  decoration: const InputDecoration(labelText: 'Area'),
                ),
                TextField(
                  controller: recipeProvider.instructionsController,
                  decoration: const InputDecoration(labelText: 'Instructions'),
                  maxLines: 3,
                ),
                TextField(
                  controller: recipeProvider.thumbnailUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: recipeProvider.youtubeUrlController,
                  decoration: const InputDecoration(labelText: 'YouTube URL'),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipeProvider.ingredientControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: recipeProvider.ingredientControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Ingredient ${index + 1}',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => recipeProvider.removeIngredient(index),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: recipeProvider.measurementControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Measurement ${index + 1}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: recipeProvider.addIngredient,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Ingredient'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                recipeProvider.editRecipe(recipe.id, context);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    }

    void _showDeleteDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Recipe'),
          content: const Text('Are you sure you want to delete this recipe?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                recipeProvider.deleteRecipe(recipe.id, context);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          if (recipe.source != null && recipe.source!.isNotEmpty ||
              recipe.youtubeUrl.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (recipe.source != null && recipe.source!.isNotEmpty)
                  Expanded(
                    child: DisplayButton(
                      onTap: () => UrlService.launchURL(context, recipe.source!),
                      icon: Icons.link,
                      text: "Source",
                      colors: [Colors.brown.shade800, Colors.brown.shade600],
                    ),
                  ),
                if (recipe.youtubeUrl.isNotEmpty)
                  Expanded(
                    child: DisplayButton(
                      onTap: () => UrlService.launchURL(context, recipe.youtubeUrl),
                      icon: Icons.play_circle_fill,
                      text: "Watch Video",
                      colors: [Colors.red.shade800, Colors.red.shade600],
                    ),
                  ),
              ],
            ),
          if (recipe.isItMine) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: DisplayButton(
                    onTap: _showEditDialog,
                    text: "Edit Recipe",
                    colors: [Colors.blue.shade800, Colors.blue.shade600],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DisplayButton(
                    onTap: _showDeleteDialog,
                    icon: Icons.delete,
                    text: "Delete Recipe",
                    colors: [Colors.red.shade800, Colors.red.shade600],
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}