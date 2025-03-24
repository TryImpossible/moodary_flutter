import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/core/l10n/l10n_manager.dart';
import 'package:moodary_flutter/core/l10n/l10n_state.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.mulit_language),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (_, int index) {
          return _LanguageSettingCell(
            locale: S.delegate.supportedLocales[index],
          );
        },
        separatorBuilder: (_, int index) {
          return const Divider(thickness: 1);
        },
        itemCount: S.delegate.supportedLocales.length,
      ),
    );
  }
}

class _LanguageSettingCell extends ConsumerWidget {
  const _LanguageSettingCell({
    super.key,
    required this.locale,
  });

  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale current = ref
        .watch(l10nManagerProvider.select((L10nState state) => state.locale));
    return ListTile(
      title: Text(locale.toLanguageText()),
      selected: current == locale,
      onTap: () => ref.read(l10nManagerProvider.notifier).change(locale),
    );
  }
}
