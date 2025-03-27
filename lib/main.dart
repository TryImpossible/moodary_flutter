import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/core/l10n/l10n_manager.dart';
import 'package:moodary_flutter/core/l10n/l10n_state.dart';
import 'package:moodary_flutter/core/theme/theme_manager.dart';
import 'package:moodary_flutter/core/theme/theme_state.dart';
import 'package:moodary_flutter/features/settings/presentation/settings/settings_screen.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeState themeState = ref.watch(themeManagerProvider);
    final L10nState l10nState = ref.watch(l10nManagerProvider);
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      theme: themeState.themeData,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: l10nState.supportedLocales,
      locale: l10nState.locale,
      home: SettingsScreen(),
    );
  }
}
