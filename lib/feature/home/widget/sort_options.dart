import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/recipe_provider.dart';

class SortOptions extends StatelessWidget {
  const SortOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black54 : Colors.black26,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text('Sort by:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: recipeProvider.sortBy,
            items: [
              DropdownMenuItem(value: 'name', child: Text('Name')),
              DropdownMenuItem(value: 'category', child: Text('Category')),
              DropdownMenuItem(value: 'area', child: Text('Area')),
            ],
            onChanged: (value) {
              if (value != null) recipeProvider.setSortBy(value);
            },
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
                recipeProvider.sortAscending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward
            ),
            onPressed: () => recipeProvider.toggleSortOrder(),
          ),
        ],
      ),
    );
  }
}