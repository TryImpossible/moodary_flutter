import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/core/l10n/app_l10n.dart';
import 'package:moodary_flutter/core/l10n/app_l10n_state.dart';
import 'package:moodary_flutter/core/utils/locale_utils.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.string.mulit_language),
        centerTitle: true,
      ),
      body: const Column(
        children: <Widget>[
          _FollowSystemItem(),
          SizedBox(height: 24),
          _LanguageOptionsList(),
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
        appL10nProvider.select((AppL10nState state) => state.isFollowSystem));
    return ListTile(
      title: Text(context.string.follow_system),
      trailing: CupertinoSwitch(
        activeColor: context.color.switchActive,
        thumbColor: context.color.switchThumb,
        value: isFollowSystem,
        onChanged: ref.read(appL10nProvider.notifier).followSystem,
      ),
    );
  }
}

class _LanguageOptionsList extends ConsumerWidget {
  const _LanguageOptionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Locale> supportedLocales = ref.watch(
        appL10nProvider.select((AppL10nState state) => state.supportedLocales));
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              context.string.language_options,
              style: TextStyle(color: context.color.secondaryText),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, int index) {
                return _LanguageOptionItem(
                  locale: supportedLocales[index],
                );
              },
              separatorBuilder: (_, int index) {
                return const Divider(thickness: 1);
              },
              itemCount: supportedLocales.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOptionItem extends ConsumerWidget {
  const _LanguageOptionItem({
    super.key,
    required this.locale,
  });

  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale? current =
        ref.watch(appL10nProvider.select((AppL10nState state) => state.locale));
    final bool isSelected = current == locale;
    return ListTile(
      title: Text(LocaleUtils.getString(locale)),
      onTap: () => ref.read(appL10nProvider.notifier).changeLocale(locale),
      trailing: isSelected
          ? Icon(Icons.check, size: 20, color: context.color.primary)
          : null,
    );
  }
}
