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

  /// Shown when a conversion fails; reason is one of chdError*
  ///
  /// In en, this message translates to:
  /// **'CHD conversion skipped: {reason}. The original files are kept.'**
  String chdConversionFailed(String reason);

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'the disc files are incomplete or unreadable'**
  String get chdErrorBadInput;

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'cancelled'**
  String get chdErrorCancelled;

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'a CHD with the same name already exists'**
  String get chdErrorExists;

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'compression failed'**
  String get chdErrorFailed;

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'not enough free space ({size} needed)'**
  String chdErrorNoSpace(String size);

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'not enough free space'**
  String get chdErrorNoSpaceShort;

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'no disc image to convert'**
  String get chdErrorNotConvertible;

  /// Reason a CHD conversion did not run
  ///
  /// In en, this message translates to:
  /// **'the CHD failed verification'**
  String get chdErrorVerify;

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

  /// Dialog button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// Button to proceed
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get commonConvert;

  /// Dialog button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

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

  /// Generic error
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get commonErrorOccurred;

  /// Button/tooltip opening the filter sheet
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get commonFilters;

  /// Placeholder while loading
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// Tooltip refreshing a list
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// Tooltip reloading a web page
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get commonReload;

  /// Tooltip removing an item
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// Button to retry a failed action
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// Button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

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

  /// Unknown value
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get commonUnknown;

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

  /// Main button of the multi-disc card
  ///
  /// In en, this message translates to:
  /// **'Download full game ({count} discs)'**
  String detailDownloadFullGame(int count);

  /// Section header listing download sources
  ///
  /// In en, this message translates to:
  /// **'Download Links'**
  String get detailDownloadLinks;

  /// Number of download links for a game
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 available} other{{count} available}}'**
  String detailLinksAvailable(int count);

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

  /// Tooltip of the button stopping a CHD conversion
  ///
  /// In en, this message translates to:
  /// **'Cancel conversion'**
  String get downloadsCancelConversion;

  /// Menu item removing completed downloads from the list
  ///
  /// In en, this message translates to:
  /// **'Clear completed'**
  String get downloadsClearCompleted;

  /// Torrent status before peers are found
  ///
  /// In en, this message translates to:
  /// **'Contacting trackers…'**
  String get downloadsContactingTrackers;

  /// Progress text during CHD conversion
  ///
  /// In en, this message translates to:
  /// **'Converting to CHD… {percent}%'**
  String downloadsConvertingProgress(int percent);

  /// Empty state body
  ///
  /// In en, this message translates to:
  /// **'Browse ROMs and tap download to get started'**
  String get downloadsEmptyBody;

  /// Empty state title
  ///
  /// In en, this message translates to:
  /// **'No downloads yet'**
  String get downloadsEmptyTitle;

  /// Status while an archive is extracted
  ///
  /// In en, this message translates to:
  /// **'Extracting…'**
  String get downloadsExtracting;

  /// Generic download error
  ///
  /// In en, this message translates to:
  /// **'Download failed'**
  String get downloadsFailed;

  /// Error shown when a download needs an Internet Archive login
  ///
  /// In en, this message translates to:
  /// **'Internet Archive login required'**
  String get downloadsIaLoginRequired;

  /// Snackbar after logging in from a failed download
  ///
  /// In en, this message translates to:
  /// **'Logged in! Retrying download...'**
  String get downloadsLoggedInRetrying;

  /// Button opening the Internet Archive login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get downloadsLogin;

  /// Appended to a queued item that is paused
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get downloadsPausedSuffix;

  /// Torrent peers while fetching metadata
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 peer connected} other{{count} peers connected}}'**
  String downloadsPeersConnected(int count);

  /// Torrent swarm summary
  ///
  /// In en, this message translates to:
  /// **'{peers, plural, =1{1 peer} other{{peers} peers}} • {seeds, plural, =1{1 seed} other{{seeds} seeds}}'**
  String downloadsPeersSeeds(int peers, int seeds);

  /// Downloads section header with item count
  ///
  /// In en, this message translates to:
  /// **'Completed ({count})'**
  String downloadsSectionCompleted(int count);

  /// Downloads section header with item count
  ///
  /// In en, this message translates to:
  /// **'Downloading ({count})'**
  String downloadsSectionDownloading(int count);

  /// Downloads section header with item count
  ///
  /// In en, this message translates to:
  /// **'Failed ({count})'**
  String downloadsSectionFailed(int count);

  /// Downloads section header with item count
  ///
  /// In en, this message translates to:
  /// **'Queue ({count})'**
  String downloadsSectionQueue(int count);

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled.'**
  String get errorCancelled;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Unable to connect. Please check your internet connection.'**
  String get errorCannotConnect;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the server. Please check your internet connection.'**
  String get errorCannotConnectServer;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. The server is taking too long to respond.'**
  String get errorConnectTimeout;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Connection failed. Please try again.'**
  String get errorConnectionFailed;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Invalid request. Please try again.'**
  String get errorHttp400;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Authentication required.'**
  String get errorHttp401;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Access denied.'**
  String get errorHttp403;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'The requested content was not found.'**
  String get errorHttp404;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please wait a moment and try again.'**
  String get errorHttp429;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Server error. The service is having issues.'**
  String get errorHttp500;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Server is temporarily unavailable. Please try again later.'**
  String get errorHttp502;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Service is currently unavailable. Please try again later.'**
  String get errorHttp503;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Server took too long to respond. Please try again.'**
  String get errorHttp504;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Response timed out. The server is taking too long.'**
  String get errorReceiveTimeout;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Request failed. Please try again.'**
  String get errorRequestFailed;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Secure connection failed. Please try again later.'**
  String get errorSecureConnection;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Request timed out while sending data.'**
  String get errorSendTimeout;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get errorServerLater;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again.'**
  String get errorServerRetry;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. The server may be slow or unavailable.'**
  String get errorTimeoutSlow;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get errorTitleConnection;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get errorTitleServer;

  /// Network error message shown to the user
  ///
  /// In en, this message translates to:
  /// **'Connection Timed Out'**
  String get errorTitleTimeout;

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

  /// Login error
  ///
  /// In en, this message translates to:
  /// **'Could not retrieve Internet Archive credentials. Please try again.'**
  String get iaCredentialsError;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Internet Archive Login'**
  String get iaLoginTitle;

  /// Name of this language written in the language itself (endonym), shown in the language picker
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// Platform filter chip showing every platform
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get libraryAll;

  /// Confirm button / menu item
  ///
  /// In en, this message translates to:
  /// **'Clean Up'**
  String get libraryCleanUp;

  /// Clean up confirmation
  ///
  /// In en, this message translates to:
  /// **'Remove entries for files that no longer exist on disk?'**
  String get libraryCleanUpBody;

  /// Dialog/menu title
  ///
  /// In en, this message translates to:
  /// **'Clean Up Library'**
  String get libraryCleanUpTitle;

  /// Snackbar after clean up
  ///
  /// In en, this message translates to:
  /// **'Library cleaned up'**
  String get libraryCleanedUp;

  /// Library menu item converting every CD game shown
  ///
  /// In en, this message translates to:
  /// **'Convert all to CHD'**
  String get libraryConvertAll;

  /// Confirmation body
  ///
  /// In en, this message translates to:
  /// **'Each game is converted one after the other, then verified. The original files are deleted only once their CHD is verified. You can follow and cancel it in Downloads.'**
  String get libraryConvertAllBody;

  /// Summary after converting all
  ///
  /// In en, this message translates to:
  /// **'{converted} converted, {failed} skipped'**
  String libraryConvertAllDone(int converted, int failed);

  /// Snackbar when nothing is convertible
  ///
  /// In en, this message translates to:
  /// **'No game to convert here'**
  String get libraryConvertAllNone;

  /// Confirmation title
  ///
  /// In en, this message translates to:
  /// **'Convert {count, plural, =1{1 game} other{{count} games}} to CHD?'**
  String libraryConvertAllTitle(int count);

  /// Library action
  ///
  /// In en, this message translates to:
  /// **'Convert to CHD'**
  String get libraryConvertChd;

  /// Snackbar after a successful conversion
  ///
  /// In en, this message translates to:
  /// **'Converted to CHD'**
  String get libraryConvertedChd;

  /// Library action grouping the discs of a multi-disc game behind one .m3u
  ///
  /// In en, this message translates to:
  /// **'Create playlist'**
  String get libraryCreatePlaylist;

  /// Delete dialog body
  ///
  /// In en, this message translates to:
  /// **'Delete \"{title}\"?'**
  String libraryDeleteConfirm(String title);

  /// Dialog button: deletes the file
  ///
  /// In en, this message translates to:
  /// **'Delete File'**
  String get libraryDeleteFile;

  /// Dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete ROM'**
  String get libraryDeleteTitle;

  /// Snackbar
  ///
  /// In en, this message translates to:
  /// **'ROM deleted'**
  String get libraryDeleted;

  /// Empty state title
  ///
  /// In en, this message translates to:
  /// **'Your library is empty'**
  String get libraryEmpty;

  /// Empty state body
  ///
  /// In en, this message translates to:
  /// **'Downloaded ROMs will appear here'**
  String get libraryEmptyHint;

  /// Error snackbar
  ///
  /// In en, this message translates to:
  /// **'File no longer exists'**
  String get libraryFileMissing;

  /// Snackbar after verifying files
  ///
  /// In en, this message translates to:
  /// **'Files verified'**
  String get libraryFilesVerified;

  /// Info row label
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get libraryFormat;

  /// Badge on items whose file is gone
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get libraryMissing;

  /// Empty state for a platform filter
  ///
  /// In en, this message translates to:
  /// **'No {platform} ROMs'**
  String libraryNoPlatformRoms(String platform);

  /// Library search empty state
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String libraryNoResults(String query);

  /// Error snackbar
  ///
  /// In en, this message translates to:
  /// **'Could not open file: {error}'**
  String libraryOpenError(String error);

  /// Button opening the file in another app
  ///
  /// In en, this message translates to:
  /// **'Open with...'**
  String get libraryOpenWith;

  /// Info row label
  ///
  /// In en, this message translates to:
  /// **'Path:'**
  String get libraryPath;

  /// Error snackbar
  ///
  /// In en, this message translates to:
  /// **'File path not found'**
  String get libraryPathNotFound;

  /// Info row label
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get libraryPlatform;

  /// Snackbar after organizing a set
  ///
  /// In en, this message translates to:
  /// **'Playlist created: {title}.m3u'**
  String libraryPlaylistCreated(String title);

  /// Snackbar when some discs are not downloaded; discs is a list
  ///
  /// In en, this message translates to:
  /// **'Missing discs: {discs}'**
  String libraryPlaylistMissing(String discs);

  /// Dialog button: keeps the file
  ///
  /// In en, this message translates to:
  /// **'Remove from Library'**
  String get libraryRemoveFromLibrary;

  /// Snackbar
  ///
  /// In en, this message translates to:
  /// **'Removed from library'**
  String get libraryRemoved;

  /// Library search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search library...'**
  String get librarySearchHint;

  /// Info row label
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get librarySize;

  /// Tab with item count
  ///
  /// In en, this message translates to:
  /// **'Downloaded ({count})'**
  String libraryTabDownloaded(int count);

  /// Tab with item count
  ///
  /// In en, this message translates to:
  /// **'Wishlist ({count})'**
  String libraryTabWishlist(int count);

  /// Menu item / settings entry
  ///
  /// In en, this message translates to:
  /// **'Verify Files'**
  String get libraryVerifyFiles;

  /// Empty state title
  ///
  /// In en, this message translates to:
  /// **'Your wishlist is empty'**
  String get libraryWishlistEmpty;

  /// Error state
  ///
  /// In en, this message translates to:
  /// **'Failed to load wishlist'**
  String get libraryWishlistError;

  /// Empty state body
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on any ROM to add it here'**
  String get libraryWishlistHint;

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

  /// Android notification channel name and notification title
  ///
  /// In en, this message translates to:
  /// **'Download Complete'**
  String get notifChannelComplete;

  /// Android notification channel description
  ///
  /// In en, this message translates to:
  /// **'Notifies when downloads complete'**
  String get notifChannelCompleteDesc;

  /// Android notification channel name
  ///
  /// In en, this message translates to:
  /// **'Download Progress'**
  String get notifChannelProgress;

  /// Android notification channel description
  ///
  /// In en, this message translates to:
  /// **'Shows download progress'**
  String get notifChannelProgressDesc;

  /// Notification title while a game is converted to CHD
  ///
  /// In en, this message translates to:
  /// **'Converting to CHD'**
  String get notifConverting;

  /// Notification title
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get notifDownloading;

  /// Notification title
  ///
  /// In en, this message translates to:
  /// **'Extracting'**
  String get notifExtracting;

  /// Notification title
  ///
  /// In en, this message translates to:
  /// **'Download Failed'**
  String get notifFailed;

  /// Foreground service notification channel name
  ///
  /// In en, this message translates to:
  /// **'Download Service'**
  String get notifServiceChannel;

  /// Foreground service channel description
  ///
  /// In en, this message translates to:
  /// **'Keeps downloads running in background'**
  String get notifServiceChannelDesc;

  /// Body of the single-disc dialog
  ///
  /// In en, this message translates to:
  /// **'Download the full game so every disc and the playlist are ready, or only this disc?'**
  String get promptSetBody;

  /// Dialog checkbox
  ///
  /// In en, this message translates to:
  /// **'Don\'t ask again'**
  String get promptSetDontAsk;

  /// Dialog button
  ///
  /// In en, this message translates to:
  /// **'Full game'**
  String get promptSetFull;

  /// Dialog button
  ///
  /// In en, this message translates to:
  /// **'Only this disc'**
  String get promptSetOnlyThis;

  /// Dialog shown before downloading a single disc of a set
  ///
  /// In en, this message translates to:
  /// **'This game has {count} discs'**
  String promptSetTitle(int count);

  /// Section header
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// Section header
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get settingsAccounts;

  /// Status message
  ///
  /// In en, this message translates to:
  /// **'API key cleared'**
  String get settingsApiKeyCleared;

  /// Status message
  ///
  /// In en, this message translates to:
  /// **'API key saved'**
  String get settingsApiKeySaved;

  /// Section header
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// Per-platform switch
  ///
  /// In en, this message translates to:
  /// **'Auto-extract'**
  String get settingsAutoExtract;

  /// Settings switch
  ///
  /// In en, this message translates to:
  /// **'Convert CD games to CHD'**
  String get settingsChdEnabled;

  /// Settings switch subtitle
  ///
  /// In en, this message translates to:
  /// **'After download, CUE/BIN, GDI and ISO discs become one compressed .chd file (PlayStation, Saturn, Dreamcast, Sega CD…). The originals are deleted only after the CHD is verified.'**
  String get settingsChdEnabledHint;

  /// Per-platform switch label for CHD conversion (keep short)
  ///
  /// In en, this message translates to:
  /// **'CHD'**
  String get settingsChdPlatform;

  /// Account status while loading
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get settingsChecking;

  /// Language picker dialog title
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get settingsChooseLanguage;

  /// Dialog title
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get settingsChooseTheme;

  /// Settings tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Remove entries for missing files'**
  String get settingsCleanUpHint;

  /// Concurrent downloads subtitle
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 download at a time} other{{count} downloads at a time}}'**
  String settingsConcurrentCount(int count);

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'Concurrent Downloads'**
  String get settingsConcurrentDownloads;

  /// Concurrent downloads subtitle
  ///
  /// In en, this message translates to:
  /// **'Unlimited concurrent downloads'**
  String get settingsConcurrentUnlimited;

  /// Connection test result
  ///
  /// In en, this message translates to:
  /// **'Connected successfully'**
  String get settingsConnected;

  /// Status message
  ///
  /// In en, this message translates to:
  /// **'Credentials cleared'**
  String get settingsCredentialsCleared;

  /// Status message
  ///
  /// In en, this message translates to:
  /// **'Credentials saved'**
  String get settingsCredentialsSaved;

  /// Snackbar
  ///
  /// In en, this message translates to:
  /// **'Database deleted'**
  String get settingsDatabaseDeleted;

  /// Database download error
  ///
  /// In en, this message translates to:
  /// **'Download failed: {error}'**
  String settingsDatabaseDownloadFailed(String error);

  /// Update dialog body when not installed
  ///
  /// In en, this message translates to:
  /// **'Download the ROM database to browse and search games.'**
  String get settingsDatabaseDownloadPrompt;

  /// Settings tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Error loading database info'**
  String get settingsDatabaseError;

  /// Update dialog body
  ///
  /// In en, this message translates to:
  /// **'A new database version is available.'**
  String get settingsDatabaseNewVersion;

  /// Database download size
  ///
  /// In en, this message translates to:
  /// **'Size: {size} MB'**
  String settingsDatabaseSize(String size);

  /// Dialog title
  ///
  /// In en, this message translates to:
  /// **'Update Database'**
  String get settingsDatabaseUpdate;

  /// Snackbar
  ///
  /// In en, this message translates to:
  /// **'Database updated successfully'**
  String get settingsDatabaseUpdated;

  /// Dialog title
  ///
  /// In en, this message translates to:
  /// **'Updating Database'**
  String get settingsDatabaseUpdating;

  /// ROM database subtitle; entries is already formatted (e.g. 241K)
  ///
  /// In en, this message translates to:
  /// **'Version {version} - {entries} entries'**
  String settingsDatabaseVersion(String version, String entries);

  /// Debrid key field label
  ///
  /// In en, this message translates to:
  /// **'{provider} API key'**
  String settingsDebridApiKey(String provider);

  /// Section header
  ///
  /// In en, this message translates to:
  /// **'Debrid Service'**
  String get settingsDebridService;

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'Default Location'**
  String get settingsDefaultLocation;

  /// Menu item / dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Database'**
  String get settingsDeleteDatabase;

  /// Delete database dialog body
  ///
  /// In en, this message translates to:
  /// **'This will delete the ROM database. You will need to download it again to browse ROMs.\n\nThis can help fix issues with a corrupted database.'**
  String get settingsDeleteDatabaseBody;

  /// Menu item
  ///
  /// In en, this message translates to:
  /// **'Delete & Reset'**
  String get settingsDeleteReset;

  /// Settings switch
  ///
  /// In en, this message translates to:
  /// **'Disable Auto-Extract'**
  String get settingsDisableAutoExtract;

  /// Settings switch subtitle
  ///
  /// In en, this message translates to:
  /// **'Keep downloaded archives as-is without extracting'**
  String get settingsDisableAutoExtractHint;

  /// Settings switch
  ///
  /// In en, this message translates to:
  /// **'Disable Torrents'**
  String get settingsDisableTorrents;

  /// Settings switch subtitle
  ///
  /// In en, this message translates to:
  /// **'Only use direct downloads (hides torrent-only sources)'**
  String get settingsDisableTorrentsHint;

  /// Settings switch
  ///
  /// In en, this message translates to:
  /// **'Offer the full game for multi-disc games'**
  String get settingsDiscSetPrompt;

  /// Settings switch subtitle
  ///
  /// In en, this message translates to:
  /// **'Ask before downloading a single disc of a set'**
  String get settingsDiscSetPromptHint;

  /// Section header
  ///
  /// In en, this message translates to:
  /// **'Download Locations'**
  String get settingsDownloadLocations;

  /// Credential field
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get settingsFieldApiKey;

  /// Label of an optional credential field
  ///
  /// In en, this message translates to:
  /// **'{label} (optional)'**
  String settingsFieldOptional(String label);

  /// Credential field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get settingsFieldPassword;

  /// Credential field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get settingsFieldUsername;

  /// Validation message
  ///
  /// In en, this message translates to:
  /// **'Fill in all required fields'**
  String get settingsFillRequired;

  /// Section header
  ///
  /// In en, this message translates to:
  /// **'Game Metadata'**
  String get settingsGameMetadata;

  /// Internet Archive tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Login to download protected files'**
  String get settingsIaLoginHint;

  /// Button installing an app update
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get settingsInstall;

  /// Settings tile opening the language picker
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Account subtitle
  ///
  /// In en, this message translates to:
  /// **'Logged in as {username}'**
  String settingsLoggedInAs(String username);

  /// Snackbar
  ///
  /// In en, this message translates to:
  /// **'Logged out from Internet Archive'**
  String get settingsLoggedOut;

  /// Button/dialog title
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// Logout confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout from Internet Archive?'**
  String get settingsLogoutConfirm;

  /// Metadata switch subtitle
  ///
  /// In en, this message translates to:
  /// **'Descriptions, screenshots and artwork on game pages (ScreenScraper, SteamGridDB)'**
  String get settingsMetadataSubtitle;

  /// Status message
  ///
  /// In en, this message translates to:
  /// **'No API key saved'**
  String get settingsNoApiKey;

  /// Status message
  ///
  /// In en, this message translates to:
  /// **'No credentials saved'**
  String get settingsNoCredentials;

  /// Database status
  ///
  /// In en, this message translates to:
  /// **'Not installed'**
  String get settingsNotInstalled;

  /// Account status
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get settingsNotLoggedIn;

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'Platform-Specific Locations'**
  String get settingsPlatformLocations;

  /// Settings tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Override download location for specific platforms'**
  String get settingsPlatformLocationsHint;

  /// Error
  ///
  /// In en, this message translates to:
  /// **'Failed to load platforms'**
  String get settingsPlatformsError;

  /// Debrid provider picker
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get settingsProvider;

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'ROM Database'**
  String get settingsRomDatabase;

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'ROM sources'**
  String get settingsRomSources;

  /// Settings tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Status of the catalogs that feed this app'**
  String get settingsRomSourcesHint;

  /// Button
  ///
  /// In en, this message translates to:
  /// **'Save key'**
  String get settingsSaveKey;

  /// Settings switch
  ///
  /// In en, this message translates to:
  /// **'Show game metadata'**
  String get settingsShowMetadata;

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get settingsSourceCode;

  /// Section header
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get settingsSources;

  /// Button testing a connection
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get settingsTest;

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// Theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// Theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// Theme/language option following the device
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsThemeSystem;

  /// Button
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get settingsUpdate;

  /// Settings switch
  ///
  /// In en, this message translates to:
  /// **'Use debrid service'**
  String get settingsUseDebrid;

  /// Settings switch subtitle
  ///
  /// In en, this message translates to:
  /// **'Resolve cached torrents to fast direct links (TorBox, Real-Debrid)'**
  String get settingsUseDebridHint;

  /// Platform folder subtitle when not overridden
  ///
  /// In en, this message translates to:
  /// **'Using default'**
  String get settingsUsingDefault;

  /// Settings tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Check if downloaded files still exist'**
  String get settingsVerifyFilesHint;

  /// Settings tile
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// Setup screen status
  ///
  /// In en, this message translates to:
  /// **'Checking database...'**
  String get setupChecking;

  /// Setup screen body
  ///
  /// In en, this message translates to:
  /// **'The ROM catalog database needs to be downloaded to browse and search for games.'**
  String get setupDownloadBody;

  /// Setup screen button
  ///
  /// In en, this message translates to:
  /// **'Download Database'**
  String get setupDownloadButton;

  /// Setup info label
  ///
  /// In en, this message translates to:
  /// **'Download Size'**
  String get setupDownloadSize;

  /// Setup screen title
  ///
  /// In en, this message translates to:
  /// **'Download ROM Database'**
  String get setupDownloadTitle;

  /// Setup screen status
  ///
  /// In en, this message translates to:
  /// **'Downloading database...'**
  String get setupDownloading;

  /// Setup screen error title
  ///
  /// In en, this message translates to:
  /// **'Download Failed'**
  String get setupFailed;

  /// Setup screen status
  ///
  /// In en, this message translates to:
  /// **'Database ready!'**
  String get setupReady;

  /// Setup info label
  ///
  /// In en, this message translates to:
  /// **'ROM Entries'**
  String get setupRomEntries;

  /// Size in megabytes
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String setupSizeMb(String size);

  /// Note in the multi-disc sheet when CHD conversion is on
  ///
  /// In en, this message translates to:
  /// **'Discs will be converted to CHD after download.'**
  String get sheetChdNote;

  /// Confirm button with total size
  ///
  /// In en, this message translates to:
  /// **'Download {size}'**
  String sheetConfirm(String size);

  /// Explanation under the checkbox. Keep .hidden and .m3u as is.
  ///
  /// In en, this message translates to:
  /// **'Discs go into a hidden .hidden folder and an .m3u file lets the emulator swap discs, so frontends like iiSU or ES-DE show the game once.'**
  String get sheetHiddenHelp;

  /// Checkbox in the multi-disc sheet
  ///
  /// In en, this message translates to:
  /// **'Single entry in launchers'**
  String get sheetHiddenOption;

  /// Warning in the multi-disc sheet
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 disc has no source: the playlist will be incomplete.} other{{count} discs have no source: the playlist will be incomplete.}}'**
  String sheetMissingDiscs(int count);

  /// Header above the file preview
  ///
  /// In en, this message translates to:
  /// **'Files created in {path}:'**
  String sheetResultIn(String path);

  /// Title of the multi-disc confirmation sheet
  ///
  /// In en, this message translates to:
  /// **'{title} — full game ({count} discs)'**
  String sheetTitle(String title, int count);

  /// Disc row without any download link
  ///
  /// In en, this message translates to:
  /// **'No source available'**
  String get sheetUnavailable;

  /// Size in gigabytes
  ///
  /// In en, this message translates to:
  /// **'{size} GB'**
  String sizeGb(String size);

  /// Size in megabytes
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String sizeMb(String size);

  /// Status line fragment; when is a relative time
  ///
  /// In en, this message translates to:
  /// **'checked {when}'**
  String sourcesChecked(String when);

  /// Status line fragment; numbers are pre-formatted
  ///
  /// In en, this message translates to:
  /// **'{entries} entries · {links} links'**
  String sourcesCounts(String entries, String links);

  /// Sources screen empty state
  ///
  /// In en, this message translates to:
  /// **'No sources found in the catalog database. Download or update the database from Settings → Update.'**
  String get sourcesEmpty;

  /// Error
  ///
  /// In en, this message translates to:
  /// **'Failed to load sources: {error}'**
  String sourcesLoadError(String error);

  /// Chip on sources needing an account (lower case)
  ///
  /// In en, this message translates to:
  /// **'login required'**
  String get sourcesLoginRequired;

  /// Tooltip opening the source website
  ///
  /// In en, this message translates to:
  /// **'Open {url}'**
  String sourcesOpenHomepage(String url);

  /// Chip with the source priority (lower case)
  ///
  /// In en, this message translates to:
  /// **'priority {priority}'**
  String sourcesPriority(int priority);

  /// Source health status
  ///
  /// In en, this message translates to:
  /// **'Degraded'**
  String get sourcesStatusDegraded;

  /// Source health status
  ///
  /// In en, this message translates to:
  /// **'Down'**
  String get sourcesStatusDown;

  /// Source health status
  ///
  /// In en, this message translates to:
  /// **'Stale'**
  String get sourcesStatusStale;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Caching on debrid...'**
  String get statusCachingDebrid;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// Download status while converting to CHD
  ///
  /// In en, this message translates to:
  /// **'Converting to CHD...'**
  String get statusConverting;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get statusDownloading;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Downloading (Torrent)'**
  String get statusDownloadingTorrent;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Extracting...'**
  String get statusExtracting;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get statusFailed;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Finding peers...'**
  String get statusFindingPeers;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get statusPaused;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Resolving via debrid...'**
  String get statusResolvingDebrid;

  /// Download status shown under a download
  ///
  /// In en, this message translates to:
  /// **'Waiting...'**
  String get statusWaiting;

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

  /// Relative time
  ///
  /// In en, this message translates to:
  /// **'{n}d ago'**
  String timeDaysAgo(int n);

  /// Relative time
  ///
  /// In en, this message translates to:
  /// **'{n}h ago'**
  String timeHoursAgo(int n);

  /// Relative time
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get timeJustNow;

  /// Relative time
  ///
  /// In en, this message translates to:
  /// **'{n}m ago'**
  String timeMinutesAgo(int n);

  /// Relative time
  ///
  /// In en, this message translates to:
  /// **'{n}mo ago'**
  String timeMonthsAgo(int n);

  /// Relative time
  ///
  /// In en, this message translates to:
  /// **'{n}y ago'**
  String timeYearsAgo(int n);

  /// Update tile title
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get updateAvailable;

  /// Snackbar shown at startup when a newer app version exists
  ///
  /// In en, this message translates to:
  /// **'Update available: v{version}'**
  String updateAvailableSnack(String version);

  /// Update tile title
  ///
  /// In en, this message translates to:
  /// **'Check for Updates'**
  String get updateCheck;

  /// Update tile title
  ///
  /// In en, this message translates to:
  /// **'Checking for Updates...'**
  String get updateChecking;

  /// Update tile title
  ///
  /// In en, this message translates to:
  /// **'Downloading Update...'**
  String get updateDownloading;

  /// Update download progress
  ///
  /// In en, this message translates to:
  /// **'Downloading... {progress}%'**
  String updateDownloadingProgress(int progress);

  /// Update tile title
  ///
  /// In en, this message translates to:
  /// **'Update Check Failed'**
  String get updateFailed;

  /// Update tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get updatePleaseWait;

  /// Update tile title
  ///
  /// In en, this message translates to:
  /// **'Ready to Install'**
  String get updateReady;

  /// Update subtitle
  ///
  /// In en, this message translates to:
  /// **'Tap Install to update to {version}'**
  String updateTapInstall(String version);

  /// Update tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Tap to check for new versions'**
  String get updateTapToCheck;

  /// Update subtitle
  ///
  /// In en, this message translates to:
  /// **'Version {version} is available'**
  String updateVersionAvailable(String version);
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
