import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/config/resources/app_dimens.dart';
import 'package:moodary_flutter/config/resources/app_images.dart';
import 'package:moodary_flutter/core/theme/app_theme_colors.dart';

extension ResourcesContext on BuildContext {
  AppLocalizations get string => AppLocalizations.of(this);

  AppThemeColors get color => Theme.of(this).extension<AppThemeColors>()!;

  AppImages get image => defaultAppImages;

  AppDimens get dimen => defaultAppDimens;
}
