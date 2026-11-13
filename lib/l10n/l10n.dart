import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Strings for code without a [BuildContext] (notifications, background
/// service). Unsupported locales fall back to English.
AppLocalizations l10nFor(Locale locale) {
  final supported = AppLocalizations.supportedLocales
      .any((l) => l.languageCode == locale.languageCode);
  return lookupAppLocalizations(supported ? locale : const Locale('en'));
}
