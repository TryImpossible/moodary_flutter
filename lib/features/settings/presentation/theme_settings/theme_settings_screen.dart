import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/core/theme/app_theme.dart';
import 'package:moodary_flutter/core/theme/app_theme_state.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.string.theme),
        centerTitle: true,
      ),
      body: const Column(
        children: <Widget>[
          _FollowSystemItem(),
          SizedBox(height: 24),
          _ThemeOptionsList(),
        ],
      ),
    );
  }
}

class _FollowSystemItem extends ConsumerWidget {
  const _FollowSystemItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFollowSystem = ref.watch(
        appThemeProvider.select((AppThemeState state) => state.isFollowSystem));
    return ListTile(
      title: Text(context.string.follow_system),
      trailing: CupertinoSwitch(
        activeColor: context.color.switchActive,
        thumbColor: context.color.switchThumb,
        value: isFollowSystem,
        onChanged: ref.read(appThemeProvider.notifier).followSystem,
      ),
    );
  }
}

class _ThemeOptionsList extends ConsumerWidget {
  const _ThemeOptionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFollowSystem = ref.watch(
        appThemeProvider.select((AppThemeState state) => state.isFollowSystem));
    final List<ThemeStyle> supportedStyles = ref.watch(appThemeProvider
        .select((AppThemeState state) => state.supportedStyles));
    return Visibility(
      visible: !isFollowSystem,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                context.string.theme_options,
                style: TextStyle(color: context.color.secondaryText),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, int index) {
                  return _ThemeOptionsItem(
                    style: supportedStyles[index],
                  );
                },
                separatorBuilder: (_, int index) {
                  return const Divider(thickness: 1);
                },
                itemCount: supportedStyles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOptionsItem extends ConsumerWidget {
  const _ThemeOptionsItem({
    super.key,
    required this.style,
  });

  final ThemeStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeStyle current = ref
        .watch(appThemeProvider.select((AppThemeState state) => state.style));
    final bool isSelected = current == style;
    return ListTile(
      title: Text(style.getString(context)),
      onTap: () => ref.read(appThemeProvider.notifier).changeTheme(style),
      trailing: isSelected
          ? Icon(Icons.check, size: 20, color: context.color.primary)
          : null,
    );
  }
}
