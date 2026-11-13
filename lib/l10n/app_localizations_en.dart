// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get browseClearFilters => 'Clear filters';

  @override
  String get browseEmptyBody => 'Enter a game name or use filters to browse';

  @override
  String get browseEmptyTitle => 'Search for ROMs';

  @override
  String get browseFeelingLucky => 'I\'m Feeling Lucky';

  @override
  String get browseGridView => 'Grid view';

  @override
  String get browseListView => 'List view';

  @override
  String get browseNoEntries => 'No entries found in database';

  @override
  String get browseNoResults => 'No results found';

  @override
  String get browseRandom => 'Random';

  @override
  String get browseRecentlyViewed => 'Recently Viewed';

  @override
  String browseResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
    );
    return '$_temp0';
  }

  @override
  String browseResultCountMore(int count) {
    return '$count+ results';
  }

  @override
  String get browseSearchHint => 'Search ROMs...';

  @override
  String get browseUseSearchBar => 'Use the search bar above to find more ROMs';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonClose => 'Close';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonDownload => 'Download';

  @override
  String get commonDownloaded => 'Downloaded';

  @override
  String get commonErrorOccurred => 'An error occurred';

  @override
  String get commonFilters => 'Filters';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonReload => 'Reload';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonTryAgain => 'Try Again';

  @override
  String get commonTryAgainTooltip => 'Try again';

  @override
  String get commonUnknown => 'Unknown';

  @override
  String get commonView => 'View';

  @override
  String get detailAbout => 'About';

  @override
  String detailAchievements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count achievements',
      one: '1 achievement',
    );
    return '$_temp0';
  }

  @override
  String get detailAddToWishlist => 'Add to wishlist';

  @override
  String detailAddedToQueue(String title) {
    return 'Added \"$title\" to download queue';
  }

  @override
  String get detailAddedToWishlist => 'Added to wishlist';

  @override
  String get detailAllTorrents =>
      'All download links are torrents.\nEnable torrents in Settings to download.';

  @override
  String get detailAlreadyDownloaded => 'Already downloaded';

  @override
  String detailAlreadyIs(String title, String status) {
    return '\"$title\" is $status';
  }

  @override
  String get detailDirect => 'Direct';

  @override
  String get detailDiscGameBody =>
      'Download every disc and generate an .m3u playlist so your emulator can swap discs.';

  @override
  String detailDiscGameTitle(int count) {
    return '$count-disc game';
  }

  @override
  String detailDiscLabel(int index) {
    return 'Disc $index';
  }

  @override
  String detailDiscsDuplicate(int count) {
    return '$count already added';
  }

  @override
  String detailDiscsQueued(int count) {
    return '$count queued';
  }

  @override
  String detailDiscsSummary(String parts) {
    return 'Discs: $parts';
  }

  @override
  String detailDiscsUnavailable(int count) {
    return '$count unavailable';
  }

  @override
  String detailDownloadAllDiscs(int count) {
    return 'Download all $count discs';
  }

  @override
  String get detailDownloadLinks => 'Download Links';

  @override
  String get detailLogIn => 'Log In';

  @override
  String get detailLoginAndDownload => 'Login & Download';

  @override
  String get detailLoginPrompt =>
      'This file requires an Internet Archive account to download. Would you like to log in now?';

  @override
  String get detailLoginRequired => 'Login Required';

  @override
  String get detailNoDiscsAvailable => 'No discs available to download';

  @override
  String get detailNoLinks => 'No download links available';

  @override
  String get detailNotFound => 'Entry not found';

  @override
  String get detailReadMore => 'Read more';

  @override
  String get detailRemoveFromWishlist => 'Remove from wishlist';

  @override
  String get detailRemovedFromWishlist => 'Removed from wishlist';

  @override
  String get detailShowLess => 'Show less';

  @override
  String get detailStatusDownloaded => 'already downloaded';

  @override
  String get detailStatusDownloading => 'currently downloading';

  @override
  String get detailStatusInQueue => 'in queue';

  @override
  String get detailStatusPaused => 'paused in queue';

  @override
  String get detailStatusQueued => 'already in queue';

  @override
  String get detailTorrent => 'Torrent';

  @override
  String get downloadsClearCompleted => 'Clear completed';

  @override
  String get downloadsContactingTrackers => 'Contacting trackers…';

  @override
  String get downloadsEmptyBody =>
      'Browse ROMs and tap download to get started';

  @override
  String get downloadsEmptyTitle => 'No downloads yet';

  @override
  String get downloadsExtracting => 'Extracting…';

  @override
  String get downloadsFailed => 'Download failed';

  @override
  String get downloadsIaLoginRequired => 'Internet Archive login required';

  @override
  String get downloadsLoggedInRetrying => 'Logged in! Retrying download...';

  @override
  String get downloadsLogin => 'Login';

  @override
  String get downloadsPausedSuffix => 'Paused';

  @override
  String downloadsPeersConnected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peers connected',
      one: '1 peer connected',
    );
    return '$_temp0';
  }

  @override
  String downloadsPeersSeeds(int peers, int seeds) {
    String _temp0 = intl.Intl.pluralLogic(
      peers,
      locale: localeName,
      other: '$peers peers',
      one: '1 peer',
    );
    String _temp1 = intl.Intl.pluralLogic(
      seeds,
      locale: localeName,
      other: '$seeds seeds',
      one: '1 seed',
    );
    return '$_temp0 • $_temp1';
  }

  @override
  String downloadsSectionCompleted(int count) {
    return 'Completed ($count)';
  }

  @override
  String downloadsSectionDownloading(int count) {
    return 'Downloading ($count)';
  }

  @override
  String downloadsSectionFailed(int count) {
    return 'Failed ($count)';
  }

  @override
  String downloadsSectionQueue(int count) {
    return 'Queue ($count)';
  }

  @override
  String get errorCancelled => 'Request was cancelled.';

  @override
  String get errorCannotConnect =>
      'Unable to connect. Please check your internet connection.';

  @override
  String get errorCannotConnectServer =>
      'Unable to connect to the server. Please check your internet connection.';

  @override
  String get errorConnectTimeout =>
      'Connection timed out. The server is taking too long to respond.';

  @override
  String get errorConnectionFailed => 'Connection failed. Please try again.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorHttp400 => 'Invalid request. Please try again.';

  @override
  String get errorHttp401 => 'Authentication required.';

  @override
  String get errorHttp403 => 'Access denied.';

  @override
  String get errorHttp404 => 'The requested content was not found.';

  @override
  String get errorHttp429 =>
      'Too many requests. Please wait a moment and try again.';

  @override
  String get errorHttp500 => 'Server error. The service is having issues.';

  @override
  String get errorHttp502 =>
      'Server is temporarily unavailable. Please try again later.';

  @override
  String get errorHttp503 =>
      'Service is currently unavailable. Please try again later.';

  @override
  String get errorHttp504 =>
      'Server took too long to respond. Please try again.';

  @override
  String get errorReceiveTimeout =>
      'Response timed out. The server is taking too long.';

  @override
  String get errorRequestFailed => 'Request failed. Please try again.';

  @override
  String get errorSecureConnection =>
      'Secure connection failed. Please try again later.';

  @override
  String get errorSendTimeout => 'Request timed out while sending data.';

  @override
  String get errorServerLater => 'Server error. Please try again later.';

  @override
  String get errorServerRetry => 'Server error. Please try again.';

  @override
  String get errorTimeoutSlow =>
      'Connection timed out. The server may be slow or unavailable.';

  @override
  String get errorTitle => 'Error';

  @override
  String get errorTitleConnection => 'Connection Error';

  @override
  String get errorTitleServer => 'Server Error';

  @override
  String get errorTitleTimeout => 'Connection Timed Out';

  @override
  String get filterApply => 'Apply Filters';

  @override
  String get filterClearAll => 'Clear all';

  @override
  String get filterHasAchievements => 'Has Achievements';

  @override
  String get filterPlatforms => 'Platforms';

  @override
  String filterPlatformsError(String error) {
    return 'Error loading platforms: $error';
  }

  @override
  String get filterRegions => 'Regions';

  @override
  String filterRegionsError(String error) {
    return 'Error loading regions: $error';
  }

  @override
  String get iaCredentialsError =>
      'Could not retrieve Internet Archive credentials. Please try again.';

  @override
  String get iaLoginTitle => 'Internet Archive Login';

  @override
  String get languageName => 'English';

  @override
  String get libraryAll => 'All';

  @override
  String get libraryCleanUp => 'Clean Up';

  @override
  String get libraryCleanUpBody =>
      'Remove entries for files that no longer exist on disk?';

  @override
  String get libraryCleanUpTitle => 'Clean Up Library';

  @override
  String get libraryCleanedUp => 'Library cleaned up';

  @override
  String libraryDeleteConfirm(String title) {
    return 'Delete \"$title\"?';
  }

  @override
  String get libraryDeleteFile => 'Delete File';

  @override
  String get libraryDeleteTitle => 'Delete ROM';

  @override
  String get libraryDeleted => 'ROM deleted';

  @override
  String get libraryEmpty => 'Your library is empty';

  @override
  String get libraryEmptyHint => 'Downloaded ROMs will appear here';

  @override
  String get libraryFileMissing => 'File no longer exists';

  @override
  String get libraryFilesVerified => 'Files verified';

  @override
  String get libraryFormat => 'Format';

  @override
  String get libraryMissing => 'Missing';

  @override
  String libraryNoPlatformRoms(String platform) {
    return 'No $platform ROMs';
  }

  @override
  String libraryNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String libraryOpenError(String error) {
    return 'Could not open file: $error';
  }

  @override
  String get libraryOpenWith => 'Open with...';

  @override
  String get libraryPath => 'Path:';

  @override
  String get libraryPathNotFound => 'File path not found';

  @override
  String get libraryPlatform => 'Platform';

  @override
  String get libraryRemoveFromLibrary => 'Remove from Library';

  @override
  String get libraryRemoved => 'Removed from library';

  @override
  String get librarySearchHint => 'Search library...';

  @override
  String get librarySize => 'Size';

  @override
  String libraryTabDownloaded(int count) {
    return 'Downloaded ($count)';
  }

  @override
  String libraryTabWishlist(int count) {
    return 'Wishlist ($count)';
  }

  @override
  String get libraryVerifyFiles => 'Verify Files';

  @override
  String get libraryWishlistEmpty => 'Your wishlist is empty';

  @override
  String get libraryWishlistError => 'Failed to load wishlist';

  @override
  String get libraryWishlistHint =>
      'Tap the heart icon on any ROM to add it here';

  @override
  String get navBrowse => 'Browse';

  @override
  String get navDownloads => 'Downloads';

  @override
  String get navLibrary => 'Library';

  @override
  String get navSettings => 'Settings';

  @override
  String get notifChannelComplete => 'Download Complete';

  @override
  String get notifChannelCompleteDesc => 'Notifies when downloads complete';

  @override
  String get notifChannelProgress => 'Download Progress';

  @override
  String get notifChannelProgressDesc => 'Shows download progress';

  @override
  String get notifDownloading => 'Downloading';

  @override
  String get notifExtracting => 'Extracting';

  @override
  String get notifFailed => 'Download Failed';

  @override
  String get notifServiceChannel => 'Download Service';

  @override
  String get notifServiceChannelDesc => 'Keeps downloads running in background';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAccounts => 'Accounts';

  @override
  String get settingsApiKeyCleared => 'API key cleared';

  @override
  String get settingsApiKeySaved => 'API key saved';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAutoExtract => 'Auto-extract';

  @override
  String get settingsChecking => 'Checking...';

  @override
  String get settingsChooseLanguage => 'Choose Language';

  @override
  String get settingsChooseTheme => 'Choose Theme';

  @override
  String get settingsCleanUpHint => 'Remove entries for missing files';

  @override
  String settingsConcurrentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count downloads at a time',
      one: '1 download at a time',
    );
    return '$_temp0';
  }

  @override
  String get settingsConcurrentDownloads => 'Concurrent Downloads';

  @override
  String get settingsConcurrentUnlimited => 'Unlimited concurrent downloads';

  @override
  String get settingsConnected => 'Connected successfully';

  @override
  String get settingsCredentialsCleared => 'Credentials cleared';

  @override
  String get settingsCredentialsSaved => 'Credentials saved';

  @override
  String get settingsDatabaseDeleted => 'Database deleted';

  @override
  String settingsDatabaseDownloadFailed(String error) {
    return 'Download failed: $error';
  }

  @override
  String get settingsDatabaseDownloadPrompt =>
      'Download the ROM database to browse and search games.';

  @override
  String get settingsDatabaseError => 'Error loading database info';

  @override
  String get settingsDatabaseNewVersion =>
      'A new database version is available.';

  @override
  String settingsDatabaseSize(String size) {
    return 'Size: $size MB';
  }

  @override
  String get settingsDatabaseUpdate => 'Update Database';

  @override
  String get settingsDatabaseUpdated => 'Database updated successfully';

  @override
  String get settingsDatabaseUpdating => 'Updating Database';

  @override
  String settingsDatabaseVersion(String version, String entries) {
    return 'Version $version - $entries entries';
  }

  @override
  String settingsDebridApiKey(String provider) {
    return '$provider API key';
  }

  @override
  String get settingsDebridService => 'Debrid Service';

  @override
  String get settingsDefaultLocation => 'Default Location';

  @override
  String get settingsDeleteDatabase => 'Delete Database';

  @override
  String get settingsDeleteDatabaseBody =>
      'This will delete the ROM database. You will need to download it again to browse ROMs.\n\nThis can help fix issues with a corrupted database.';

  @override
  String get settingsDeleteReset => 'Delete & Reset';

  @override
  String get settingsDisableAutoExtract => 'Disable Auto-Extract';

  @override
  String get settingsDisableAutoExtractHint =>
      'Keep downloaded archives as-is without extracting';

  @override
  String get settingsDisableTorrents => 'Disable Torrents';

  @override
  String get settingsDisableTorrentsHint =>
      'Only use direct downloads (hides torrent-only sources)';

  @override
  String get settingsDownloadLocations => 'Download Locations';

  @override
  String get settingsFieldApiKey => 'API key';

  @override
  String settingsFieldOptional(String label) {
    return '$label (optional)';
  }

  @override
  String get settingsFieldPassword => 'Password';

  @override
  String get settingsFieldUsername => 'Username';

  @override
  String get settingsFillRequired => 'Fill in all required fields';

  @override
  String get settingsGameMetadata => 'Game Metadata';

  @override
  String get settingsIaLoginHint => 'Login to download protected files';

  @override
  String get settingsInstall => 'Install';

  @override
  String get settingsLanguage => 'Language';

  @override
  String settingsLoggedInAs(String username) {
    return 'Logged in as $username';
  }

  @override
  String get settingsLoggedOut => 'Logged out from Internet Archive';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get settingsLogoutConfirm =>
      'Are you sure you want to logout from Internet Archive?';

  @override
  String get settingsMetadataSubtitle =>
      'Descriptions, screenshots and artwork on game pages (ScreenScraper, SteamGridDB)';

  @override
  String get settingsNoApiKey => 'No API key saved';

  @override
  String get settingsNoCredentials => 'No credentials saved';

  @override
  String get settingsNotInstalled => 'Not installed';

  @override
  String get settingsNotLoggedIn => 'Not logged in';

  @override
  String get settingsPlatformLocations => 'Platform-Specific Locations';

  @override
  String get settingsPlatformLocationsHint =>
      'Override download location for specific platforms';

  @override
  String get settingsPlatformsError => 'Failed to load platforms';

  @override
  String get settingsProvider => 'Provider';

  @override
  String get settingsRomDatabase => 'ROM Database';

  @override
  String get settingsRomSources => 'ROM sources';

  @override
  String get settingsRomSourcesHint =>
      'Status of the catalogs that feed this app';

  @override
  String get settingsSaveKey => 'Save key';

  @override
  String get settingsShowMetadata => 'Show game metadata';

  @override
  String get settingsSourceCode => 'Source Code';

  @override
  String get settingsSources => 'Sources';

  @override
  String get settingsTest => 'Test';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeSystem => 'System default';

  @override
  String get settingsUpdate => 'Update';

  @override
  String get settingsUseDebrid => 'Use debrid service';

  @override
  String get settingsUseDebridHint =>
      'Resolve cached torrents to fast direct links (TorBox, Real-Debrid)';

  @override
  String get settingsUsingDefault => 'Using default';

  @override
  String get settingsVerifyFilesHint => 'Check if downloaded files still exist';

  @override
  String get settingsVersion => 'Version';

  @override
  String get setupChecking => 'Checking database...';

  @override
  String get setupDownloadBody =>
      'The ROM catalog database needs to be downloaded to browse and search for games.';

  @override
  String get setupDownloadButton => 'Download Database';

  @override
  String get setupDownloadSize => 'Download Size';

  @override
  String get setupDownloadTitle => 'Download ROM Database';

  @override
  String get setupDownloading => 'Downloading database...';

  @override
  String get setupFailed => 'Download Failed';

  @override
  String get setupReady => 'Database ready!';

  @override
  String get setupRomEntries => 'ROM Entries';

  @override
  String setupSizeMb(String size) {
    return '$size MB';
  }

  @override
  String sourcesChecked(String when) {
    return 'checked $when';
  }

  @override
  String sourcesCounts(String entries, String links) {
    return '$entries entries · $links links';
  }

  @override
  String get sourcesEmpty =>
      'No sources found in the catalog database. Download or update the database from Settings → Update.';

  @override
  String sourcesLoadError(String error) {
    return 'Failed to load sources: $error';
  }

  @override
  String get sourcesLoginRequired => 'login required';

  @override
  String sourcesOpenHomepage(String url) {
    return 'Open $url';
  }

  @override
  String sourcesPriority(int priority) {
    return 'priority $priority';
  }

  @override
  String get sourcesStatusDegraded => 'Degraded';

  @override
  String get sourcesStatusDown => 'Down';

  @override
  String get sourcesStatusStale => 'Stale';

  @override
  String get statusCachingDebrid => 'Caching on debrid...';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusDownloading => 'Downloading...';

  @override
  String get statusDownloadingTorrent => 'Downloading (Torrent)';

  @override
  String get statusExtracting => 'Extracting...';

  @override
  String get statusFailed => 'Failed';

  @override
  String get statusFindingPeers => 'Finding peers...';

  @override
  String get statusPaused => 'Paused';

  @override
  String get statusResolvingDebrid => 'Resolving via debrid...';

  @override
  String get statusWaiting => 'Waiting...';

  @override
  String get storagePermissionBody =>
      'Romgi needs storage access to save ROMs to a location accessible by your file manager and emulators.\n\nOn the next screen, please enable \"Allow access to manage all files\".';

  @override
  String get storagePermissionTitle => 'Storage Permission';

  @override
  String timeDaysAgo(int n) {
    return '${n}d ago';
  }

  @override
  String timeHoursAgo(int n) {
    return '${n}h ago';
  }

  @override
  String get timeJustNow => 'just now';

  @override
  String timeMinutesAgo(int n) {
    return '${n}m ago';
  }

  @override
  String timeMonthsAgo(int n) {
    return '${n}mo ago';
  }

  @override
  String timeYearsAgo(int n) {
    return '${n}y ago';
  }

  @override
  String get updateAvailable => 'Update Available';

  @override
  String updateAvailableSnack(String version) {
    return 'Update available: v$version';
  }

  @override
  String get updateCheck => 'Check for Updates';

  @override
  String get updateChecking => 'Checking for Updates...';

  @override
  String get updateDownloading => 'Downloading Update...';

  @override
  String updateDownloadingProgress(int progress) {
    return 'Downloading... $progress%';
  }

  @override
  String get updateFailed => 'Update Check Failed';

  @override
  String get updatePleaseWait => 'Please wait...';

  @override
  String get updateReady => 'Ready to Install';

  @override
  String updateTapInstall(String version) {
    return 'Tap Install to update to $version';
  }

  @override
  String get updateTapToCheck => 'Tap to check for new versions';

  @override
  String updateVersionAvailable(String version) {
    return 'Version $version is available';
  }
}
