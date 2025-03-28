import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/features/settings/presentation/language_settings/language_settings_screen.dart';
import 'package:moodary_flutter/features/settings/presentation/theme_settings/theme_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.string.settings,
          style: TextStyle(color: context.color.appBarText),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _SettingsCell(
            text: context.string.theme,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const ThemeSettingsScreen();
                  },
                ),
              );
            },
          ),
          const Divider(thickness: 1),
          _SettingsCell(
            text: context.string.mulit_language,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const LanguageSettingsScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsCell extends StatelessWidget {
  const _SettingsCell({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
