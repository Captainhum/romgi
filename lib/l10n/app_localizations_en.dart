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
  String get commonDownload => 'Download';

  @override
  String get commonDownloaded => 'Downloaded';

  @override
  String get commonFilters => 'Filters';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonTryAgain => 'Try Again';

  @override
  String get commonTryAgainTooltip => 'Try again';

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
  String updateAvailableSnack(String version) {
    return 'Update available: v$version';
  }
}
