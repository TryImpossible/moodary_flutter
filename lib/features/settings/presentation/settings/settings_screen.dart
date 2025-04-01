import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/core/services/app_services.dart';

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
              AppServices.navigation.goThemeSettings();
            },
          ),
          const Divider(thickness: 1),
          _SettingsCell(
            text: context.string.mulit_language,
            onTap: () {
              AppServices.navigation.goLangeSettings();
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
