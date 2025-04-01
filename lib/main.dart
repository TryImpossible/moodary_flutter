import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/config/routes/app_route_name.dart';
import 'package:moodary_flutter/config/routes/app_route_table.dart';
import 'package:moodary_flutter/core/l10n/app_l10n.dart';
import 'package:moodary_flutter/core/l10n/app_l10n_state.dart';
import 'package:moodary_flutter/core/router/app_router.dart';
import 'package:moodary_flutter/core/router/log_nav_observer.dart';
import 'package:moodary_flutter/core/storages/app_storage.dart';
import 'package:moodary_flutter/core/theme/app_theme.dart';
import 'package:moodary_flutter/core/theme/app_theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await AppStorage.initDefault();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  AppRouter.getDefault()
      .setNavigatorKey(navigatorKey)
      .setInitialRoute(AppRouteName.settings.path)
      .registerRoutes(AppRouteTable.routes)
      .addObserver(LogNavObserver());
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppThemeState themeState = ref.watch(appThemeProvider);
    final AppL10nState l10nState = ref.watch(appL10nProvider);
    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => context.string.app_name,
      theme: themeState.theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (
        Locale? locale,
        Iterable<Locale> supportedLocales,
      ) {
        if (l10nState.isFollowSystem) {
          return l10nState.locale;
        }
        if (supportedLocales.contains(locale)) {
          return locale;
        } else {
          for (final Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
        }
        return const Locale.fromSubtags(languageCode: 'en');
      },
      supportedLocales: l10nState.supportedLocales,
      locale: l10nState.locale,
      routerConfig: AppRouter.getDefault().routerConfig,
    );
  }
}
