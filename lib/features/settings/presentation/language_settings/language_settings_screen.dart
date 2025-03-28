import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/core/l10n/l10n_manager.dart';
import 'package:moodary_flutter/core/l10n/l10n_state.dart';

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Locale> supportedLocales = ref.watch(l10nManagerProvider
        .select((L10nState state) => state.supportedLocales));
    return Scaffold(
      appBar: AppBar(
        title: Text(context.string.mulit_language),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (_, int index) {
          return _LanguageSettingsCell(
            locale: supportedLocales[index],
          );
        },
        separatorBuilder: (_, int index) {
          return const Divider(thickness: 1);
        },
        itemCount: supportedLocales.length,
      ),
    );
  }
}

class _LanguageSettingsCell extends ConsumerWidget {
  const _LanguageSettingsCell({
    super.key,
    required this.locale,
  });

  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale current = ref
        .watch(l10nManagerProvider.select((L10nState state) => state.locale));
    return ListTile(
      title: Text(locale.getString()),
      selected: current == locale,
      onTap: () => ref.read(l10nManagerProvider.notifier).change(locale),
    );
  }
}
