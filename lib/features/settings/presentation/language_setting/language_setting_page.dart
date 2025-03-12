import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/core/l10n/l10n.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({super.key});

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

class _LanguageSettingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _LanguageSettingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(S.current.mulit_language),
      centerTitle: true,
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
    final Locale current =
        ref.watch(l10nProvider.select((L10nState state) => state.locale));
    return ListTile(
      title: Text(locale.toLanguageText()),
      selected: current == locale,
      onTap: () => ref.read(l10nProvider.notifier).change(locale),
    );
  }
}
