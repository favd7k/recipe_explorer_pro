import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../../providers/recipe_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text('settings.language').tr(),
      trailing: DropdownButton<String>(
        value: context.locale.languageCode,
        onChanged: (String? newValue) {
          if (newValue != null) {
            context.setLocale(Locale(newValue));
            Provider.of<RecipeProvider>(context, listen: false).notifyListeners();
          }
        },
        items: const [
          DropdownMenuItem(
            value: 'en',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'ru',
            child: Text('Русский'),
          ),
          DropdownMenuItem(
            value: 'kk',
            child: Text('Қазақша'),
          ),
        ],
      ),
    );
  }
}