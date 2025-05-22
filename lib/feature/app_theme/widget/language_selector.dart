import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text('settings.language').tr(),
      trailing: DropdownButton<Locale>(
        value: context.locale,
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            context.setLocale(newLocale);
          }
        },
        items: const [
          DropdownMenuItem(
            value: Locale('en'),
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: Locale('ru'),
            child: Text('Русский'),
          ),
          DropdownMenuItem(
            value: Locale('kk'),
            child: Text('Қазақша'),
          ),
        ],
      ),
    );
  }
}