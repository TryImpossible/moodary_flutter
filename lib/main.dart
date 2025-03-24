import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/core/l10n/l10n_manager.dart';
import 'package:moodary_flutter/core/l10n/l10n_state.dart';
import 'package:moodary_flutter/features/settings/presentation/language_setting/language_setting_screen.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10nState l10nState = ref.watch(l10nManagerProvider);
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: l10nState.supportedLocales,
      locale: l10nState.locale,
      home: LanguageSettingScreen(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          ),
          Text(S.current.log_mood, style: const TextStyle(fontSize: 32)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                child: const Text('本地化'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('主题'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
