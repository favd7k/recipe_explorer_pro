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
          title: Text('Edit Recipe'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: recipeProvider.nameController,
                  decoration: InputDecoration(labelText: 'Recipe Name'),
                ),
                TextField(
                  controller: recipeProvider.categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: recipeProvider.areaController,
                  decoration: InputDecoration(labelText: 'Area'),
                ),
                TextField(
                  controller: recipeProvider.instructionsController,
                  decoration: InputDecoration(labelText: 'Instructions'),
                  maxLines: 3,
                ),
                TextField(
                  controller: recipeProvider.thumbnailUrlController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: recipeProvider.youtubeUrlController,
                  decoration: InputDecoration(labelText: 'YouTube URL'),
                ),
                // Ingredients and measurements
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recipeProvider.ingredientControllers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: recipeProvider.ingredientControllers[index],
                            decoration: InputDecoration(labelText: 'Ingredient'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: recipeProvider.measurementControllers[index],
                            decoration: InputDecoration(labelText: 'Measurement'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => recipeProvider.editRecipe(recipe.id, context),
              child: Text('Save'),
            ),
          ],
        ),
      );
    }

    void _showDeleteDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Recipe'),
          content: Text('Are you sure you want to delete this recipe?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => recipeProvider.deleteRecipe(recipe.id, context),
              child: Text('Delete', style: TextStyle(color: Colors.red)),
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
                      onTap: () =>
                          UrlService.launchURL(context, recipe.source!),
                      icon: Icons.link,
                      text: "Source",
                      colors: [Colors.brown.shade800, Colors.brown.shade600],
                    ),
                  ),
                if (recipe.youtubeUrl.isNotEmpty)
                  Expanded(
                    child: DisplayButton(
                      onTap: () =>
                          UrlService.launchURL(context, recipe.youtubeUrl),
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