import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/config/routes/route_name.dart';
import 'package:moodary_flutter/config/routes/route_table.dart';
import 'package:moodary_flutter/core/l10n/l10n_manager.dart';
import 'package:moodary_flutter/core/l10n/l10n_state.dart';
import 'package:moodary_flutter/core/router/app_router.dart';
import 'package:moodary_flutter/core/theme/theme_manager.dart';
import 'package:moodary_flutter/core/theme/theme_state.dart';

void main() {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  AppRouter.getDefault()
      .setNavigatorKey(navigatorKey)
      .setInitialRoute(RouteName.settings.path)
      .registerRoutes(RouteTable.routes);
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeState themeState = ref.watch(themeManagerProvider);
    final L10nState l10nState = ref.watch(l10nManagerProvider);

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => context.string.app_name,
      theme: themeState.theme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: l10nState.supportedLocales,
      locale: l10nState.locale,
      routerConfig: AppRouter.getDefault().routerConfig,
    );
  }
}
