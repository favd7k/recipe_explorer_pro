import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(AppLocalizations.of(context)!.language),
      trailing: DropdownButton<String>(
        value: currentLocale.languageCode,
        onChanged: (String? newValue) {
          if (newValue != null) {
            Locale newLocale = Locale(newValue);
            MaterialApp.of(context).rebuild();
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