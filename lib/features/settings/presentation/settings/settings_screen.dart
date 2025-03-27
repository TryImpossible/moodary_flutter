import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/features/settings/presentation/language_setting/language_setting_screen.dart';
import 'package:moodary_flutter/features/settings/presentation/theme_setting/theme_setting_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _SettingsCell(
            text: S.current.theme,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const ThemeSettingScreen();
                  },
                ),
              );
            },
          ),
          _SettingsCell(
            text: S.current.mulit_language,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const LanguageSettingScreen();
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
