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
  String get commonContinue => 'Continue';

  @override
  String get commonDownload => 'Download';

  @override
  String get commonDownloaded => 'Downloaded';

  @override
  String get commonFilters => 'Filters';

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
  String get navBrowse => 'Browse';

  @override
  String get navDownloads => 'Downloads';

  @override
  String get navLibrary => 'Library';

  @override
  String get navSettings => 'Settings';

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
