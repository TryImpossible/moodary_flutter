import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/core/theme/app_color.dart';

extension ResourcesContext on BuildContext {
  AppLocalizations get string => AppLocalizations.of(this);

  AppColor get color => Theme.of(this).extension<AppColor>()!;
}
