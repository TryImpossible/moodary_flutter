import 'dart:ui';

abstract class LocaleUtils {
  static Locale parse(String formattedString) {
    final List<String> locales = formattedString.split(RegExp(r'[-_]'));
    final String languageCode = locales.elementAt(0);
    final String? scriptCode = locales.elementAtOrNull(1);
    final String? countryCode = locales.elementAtOrNull(2);
    return Locale.fromSubtags(
      languageCode: languageCode,
      scriptCode: scriptCode,
      countryCode: countryCode,
    );
  }

  static Locale? tryParse(String? formattedString) {
    if (formattedString == null || formattedString.isEmpty) {
      return null;
    }
    try {
      return parse(formattedString);
    } catch (_) {
      return null;
    }
  }

  static String getString(Locale locale) {
    return switch (locale) {
      const Locale.fromSubtags(languageCode: 'en') => 'English',
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans') =>
        '简体中文',
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant') =>
        '繁體中文',
      _ => 'English',
    };
  }
}
