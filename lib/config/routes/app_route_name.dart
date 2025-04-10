enum AppRouteName {
  $404('/404'),
  splash('/'),
  main('/main'),
  diaryEditor('/diary-editor'),
  settings('/settings'),
  themeSettings('/theme-settings'),
  languageSettings('/language-settings');

  const AppRouteName(this.path);

  final String path;
}