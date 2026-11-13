import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Button resetting all filters
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get browseClearFilters;

  /// Empty state body on the Browse tab
  ///
  /// In en, this message translates to:
  /// **'Enter a game name or use filters to browse'**
  String get browseEmptyBody;

  /// Empty state title on the Browse tab
  ///
  /// In en, this message translates to:
  /// **'Search for ROMs'**
  String get browseEmptyTitle;

  /// Tooltip of the random game button (playful)
  ///
  /// In en, this message translates to:
  /// **'I\'m Feeling Lucky'**
  String get browseFeelingLucky;

  /// Tooltip to switch to grid layout
  ///
  /// In en, this message translates to:
  /// **'Grid view'**
  String get browseGridView;

  /// Tooltip to switch to list layout
  ///
  /// In en, this message translates to:
  /// **'List view'**
  String get browseListView;

  /// Snackbar when the random pick finds no game
  ///
  /// In en, this message translates to:
  /// **'No entries found in database'**
  String get browseNoEntries;

  /// Shown when the search returns nothing
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get browseNoResults;

  /// Button opening a random game
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get browseRandom;

  /// Header of the recently opened games list
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get browseRecentlyViewed;

  /// Number of search results
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result} other{{count} results}}'**
  String browseResultCount(int count);

  /// Number of results shown when more pages exist
  ///
  /// In en, this message translates to:
  /// **'{count}+ results'**
  String browseResultCountMore(int count);

  /// Search field placeholder
  ///
  /// In en, this message translates to:
  /// **'Search ROMs...'**
  String get browseSearchHint;

  /// Hint under the recently viewed list
  ///
  /// In en, this message translates to:
  /// **'Use the search bar above to find more ROMs'**
  String get browseUseSearchBar;

  /// Dialog button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Button clearing a list or field
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// Button to proceed
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// Button starting a download
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get commonDownload;

  /// Badge on games already downloaded
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get commonDownloaded;

  /// Button/tooltip opening the filter sheet
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get commonFilters;

  /// Button to retry a failed action
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// Button to skip an optional step
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// Button on error screens
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get commonTryAgain;

  /// Tooltip of the retry icon
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonTryAgainTooltip;

  /// Snackbar action jumping to the related tab
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get commonView;

  /// Section header of the game description
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get detailAbout;

  /// RetroAchievements count chip
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 achievement} other{{count} achievements}}'**
  String detailAchievements(int count);

  /// Tooltip of the favorite button
  ///
  /// In en, this message translates to:
  /// **'Add to wishlist'**
  String get detailAddToWishlist;

  /// Snackbar after queueing a download
  ///
  /// In en, this message translates to:
  /// **'Added \"{title}\" to download queue'**
  String detailAddedToQueue(String title);

  /// Snackbar after adding a favorite
  ///
  /// In en, this message translates to:
  /// **'Added to wishlist'**
  String get detailAddedToWishlist;

  /// Shown when torrents are disabled and only torrent links exist
  ///
  /// In en, this message translates to:
  /// **'All download links are torrents.\nEnable torrents in Settings to download.'**
  String get detailAllTorrents;

  /// Banner on a game page when it is in the library
  ///
  /// In en, this message translates to:
  /// **'Already downloaded'**
  String get detailAlreadyDownloaded;

  /// Snackbar when the game is already queued; status is one of detailStatus*
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" is {status}'**
  String detailAlreadyIs(String title, String status);

  /// Badge for direct HTTP sources
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get detailDirect;

  /// Explanation on the multi-disc card. .m3u is a file extension, keep it.
  ///
  /// In en, this message translates to:
  /// **'Download every disc and generate an .m3u playlist so your emulator can swap discs.'**
  String get detailDiscGameBody;

  /// Title of the multi-disc card
  ///
  /// In en, this message translates to:
  /// **'{count}-disc game'**
  String detailDiscGameTitle(int count);

  /// Chip label for one disc of a set
  ///
  /// In en, this message translates to:
  /// **'Disc {index}'**
  String detailDiscLabel(int index);

  /// Part of the disc set summary
  ///
  /// In en, this message translates to:
  /// **'{count} already added'**
  String detailDiscsDuplicate(int count);

  /// Part of the disc set summary
  ///
  /// In en, this message translates to:
  /// **'{count} queued'**
  String detailDiscsQueued(int count);

  /// Snackbar after queueing a disc set; parts is a comma separated list
  ///
  /// In en, this message translates to:
  /// **'Discs: {parts}'**
  String detailDiscsSummary(String parts);

  /// Part of the disc set summary
  ///
  /// In en, this message translates to:
  /// **'{count} unavailable'**
  String detailDiscsUnavailable(int count);

  /// Button downloading every disc of a set
  ///
  /// In en, this message translates to:
  /// **'Download all {count} discs'**
  String detailDownloadAllDiscs(int count);

  /// Section header listing download sources
  ///
  /// In en, this message translates to:
  /// **'Download Links'**
  String get detailDownloadLinks;

  /// Dialog button opening the login page
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get detailLogIn;

  /// Button for a source that needs login
  ///
  /// In en, this message translates to:
  /// **'Login & Download'**
  String get detailLoginAndDownload;

  /// Body of the login required dialog
  ///
  /// In en, this message translates to:
  /// **'This file requires an Internet Archive account to download. Would you like to log in now?'**
  String get detailLoginPrompt;

  /// Badge/dialog title for sources needing an Internet Archive account
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get detailLoginRequired;

  /// Snackbar when no disc of a set has a source
  ///
  /// In en, this message translates to:
  /// **'No discs available to download'**
  String get detailNoDiscsAvailable;

  /// Shown when a game has no source
  ///
  /// In en, this message translates to:
  /// **'No download links available'**
  String get detailNoLinks;

  /// Shown when the game page cannot load its entry
  ///
  /// In en, this message translates to:
  /// **'Entry not found'**
  String get detailNotFound;

  /// Expands the description
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get detailReadMore;

  /// Tooltip of the favorite button
  ///
  /// In en, this message translates to:
  /// **'Remove from wishlist'**
  String get detailRemoveFromWishlist;

  /// Snackbar after removing a favorite
  ///
  /// In en, this message translates to:
  /// **'Removed from wishlist'**
  String get detailRemovedFromWishlist;

  /// Collapses the description
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get detailShowLess;

  /// Status fragment inserted in detailAlreadyIs
  ///
  /// In en, this message translates to:
  /// **'already downloaded'**
  String get detailStatusDownloaded;

  /// Status fragment inserted in detailAlreadyIs
  ///
  /// In en, this message translates to:
  /// **'currently downloading'**
  String get detailStatusDownloading;

  /// Status fragment inserted in detailAlreadyIs
  ///
  /// In en, this message translates to:
  /// **'in queue'**
  String get detailStatusInQueue;

  /// Status fragment inserted in detailAlreadyIs
  ///
  /// In en, this message translates to:
  /// **'paused in queue'**
  String get detailStatusPaused;

  /// Status fragment inserted in detailAlreadyIs
  ///
  /// In en, this message translates to:
  /// **'already in queue'**
  String get detailStatusQueued;

  /// Badge for torrent sources
  ///
  /// In en, this message translates to:
  /// **'Torrent'**
  String get detailTorrent;

  /// Button applying the selected filters
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get filterApply;

  /// Button resetting every filter
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get filterClearAll;

  /// Filter chip: only games with RetroAchievements
  ///
  /// In en, this message translates to:
  /// **'Has Achievements'**
  String get filterHasAchievements;

  /// Filter section title
  ///
  /// In en, this message translates to:
  /// **'Platforms'**
  String get filterPlatforms;

  /// Shown when platforms fail to load
  ///
  /// In en, this message translates to:
  /// **'Error loading platforms: {error}'**
  String filterPlatformsError(String error);

  /// Filter section title
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get filterRegions;

  /// Shown when regions fail to load
  ///
  /// In en, this message translates to:
  /// **'Error loading regions: {error}'**
  String filterRegionsError(String error);

  /// Navigation tab: catalog search
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get navBrowse;

  /// Navigation tab: download queue
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get navDownloads;

  /// Navigation tab: downloaded games
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get navLibrary;

  /// Navigation tab: settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Body of the storage permission dialog. The quoted text is the Android system option name.
  ///
  /// In en, this message translates to:
  /// **'Romgi needs storage access to save ROMs to a location accessible by your file manager and emulators.\n\nOn the next screen, please enable \"Allow access to manage all files\".'**
  String get storagePermissionBody;

  /// Title of the dialog explaining the storage permission
  ///
  /// In en, this message translates to:
  /// **'Storage Permission'**
  String get storagePermissionTitle;

  /// Snackbar shown at startup when a newer app version exists
  ///
  /// In en, this message translates to:
  /// **'Update available: v{version}'**
  String updateAvailableSnack(String version);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
