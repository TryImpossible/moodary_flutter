enum RouteName {
  $404('/404'),
  splash('/'),
  main('/main'),
  settings('/settings');

  const RouteName(this.path);

  final String path;
}