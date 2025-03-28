import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/core/theme/theme_manager.dart';
import 'package:moodary_flutter/core/theme/theme_state.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ThemeStyle> supportedStyles = ref.watch(themeManagerProvider
        .select((ThemeState state) => state.supportedStyles));
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.theme),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (_, int index) {
          return _ThemeSettingsCell(style: supportedStyles[index]);
        },
        separatorBuilder: (_, int index) {
          return const Divider(thickness: 1);
        },
        itemCount: supportedStyles.length,
      ),
    );
  }
}

class _ThemeSettingsCell extends ConsumerWidget {
  const _ThemeSettingsCell({
    super.key,
    required this.style,
  });

  final ThemeStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeStyle current = ref
        .watch(themeManagerProvider.select((ThemeState state) => state.style));
    return ListTile(
      title: Text(style.text),
      selected: current == style,
      onTap: () => ref.read(themeManagerProvider.notifier).change(style),
    );
  }
}
