// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get browseClearFilters => 'Effacer les filtres';

  @override
  String get browseEmptyBody =>
      'Tape le nom d\'un jeu ou utilise les filtres pour parcourir le catalogue';

  @override
  String get browseEmptyTitle => 'Rechercher des ROM';

  @override
  String get browseFeelingLucky => 'J\'ai de la chance';

  @override
  String get browseGridView => 'Vue en grille';

  @override
  String get browseListView => 'Vue en liste';

  @override
  String get browseNoEntries => 'Aucune entrée trouvée dans la base de données';

  @override
  String get browseNoResults => 'Aucun résultat';

  @override
  String get browseRandom => 'Au hasard';

  @override
  String get browseRecentlyViewed => 'Consultés récemment';

  @override
  String browseResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats',
      one: '1 résultat',
    );
    return '$_temp0';
  }

  @override
  String browseResultCountMore(int count) {
    return '$count+ résultats';
  }

  @override
  String get browseSearchHint => 'Rechercher des ROM…';

  @override
  String get browseUseSearchBar =>
      'Utilise la barre de recherche ci-dessus pour trouver d\'autres ROM';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClear => 'Effacer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonDownload => 'Télécharger';

  @override
  String get commonDownloaded => 'Téléchargé';

  @override
  String get commonFilters => 'Filtres';

  @override
  String get commonRemove => 'Supprimer';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonTryAgain => 'Réessayer';

  @override
  String get commonTryAgainTooltip => 'Réessayer';

  @override
  String get commonView => 'Voir';

  @override
  String get detailAbout => 'À propos';

  @override
  String detailAchievements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count succès',
      one: '1 succès',
    );
    return '$_temp0';
  }

  @override
  String get detailAddToWishlist => 'Ajouter à la liste de souhaits';

  @override
  String detailAddedToQueue(String title) {
    return '« $title » ajouté à la file de téléchargement';
  }

  @override
  String get detailAddedToWishlist => 'Ajouté à la liste de souhaits';

  @override
  String get detailAllTorrents =>
      'Tous les liens sont des torrents.\nActive les torrents dans les Réglages pour télécharger.';

  @override
  String get detailAlreadyDownloaded => 'Déjà téléchargé';

  @override
  String detailAlreadyIs(String title, String status) {
    return '« $title » est $status';
  }

  @override
  String get detailDirect => 'Direct';

  @override
  String get detailDiscGameBody =>
      'Télécharge tous les disques et crée une playlist .m3u pour que ton émulateur puisse changer de disque.';

  @override
  String detailDiscGameTitle(int count) {
    return 'Jeu à $count disques';
  }

  @override
  String detailDiscLabel(int index) {
    return 'Disque $index';
  }

  @override
  String detailDiscsDuplicate(int count) {
    return '$count déjà ajouté(s)';
  }

  @override
  String detailDiscsQueued(int count) {
    return '$count en file';
  }

  @override
  String detailDiscsSummary(String parts) {
    return 'Disques : $parts';
  }

  @override
  String detailDiscsUnavailable(int count) {
    return '$count indisponible(s)';
  }

  @override
  String detailDownloadAllDiscs(int count) {
    return 'Télécharger les $count disques';
  }

  @override
  String get detailDownloadLinks => 'Liens de téléchargement';

  @override
  String get detailLogIn => 'Se connecter';

  @override
  String get detailLoginAndDownload => 'Se connecter et télécharger';

  @override
  String get detailLoginPrompt =>
      'Ce fichier nécessite un compte Internet Archive. Veux-tu te connecter maintenant ?';

  @override
  String get detailLoginRequired => 'Connexion requise';

  @override
  String get detailNoDiscsAvailable =>
      'Aucun disque disponible au téléchargement';

  @override
  String get detailNoLinks => 'Aucun lien de téléchargement disponible';

  @override
  String get detailNotFound => 'Jeu introuvable';

  @override
  String get detailReadMore => 'Lire la suite';

  @override
  String get detailRemoveFromWishlist => 'Retirer de la liste de souhaits';

  @override
  String get detailRemovedFromWishlist => 'Retiré de la liste de souhaits';

  @override
  String get detailShowLess => 'Réduire';

  @override
  String get detailStatusDownloaded => 'déjà téléchargé';

  @override
  String get detailStatusDownloading => 'en cours de téléchargement';

  @override
  String get detailStatusInQueue => 'dans la file';

  @override
  String get detailStatusPaused => 'en pause dans la file';

  @override
  String get detailStatusQueued => 'déjà dans la file';

  @override
  String get detailTorrent => 'Torrent';

  @override
  String get downloadsClearCompleted => 'Effacer les terminés';

  @override
  String get downloadsContactingTrackers => 'Contact des trackers…';

  @override
  String get downloadsEmptyBody =>
      'Parcours le catalogue et appuie sur Télécharger pour commencer';

  @override
  String get downloadsEmptyTitle => 'Aucun téléchargement';

  @override
  String get downloadsExtracting => 'Extraction…';

  @override
  String get downloadsFailed => 'Échec du téléchargement';

  @override
  String get downloadsIaLoginRequired => 'Connexion Internet Archive requise';

  @override
  String get downloadsLoggedInRetrying => 'Connecté ! Nouvelle tentative…';

  @override
  String get downloadsLogin => 'Connexion';

  @override
  String get downloadsPausedSuffix => 'En pause';

  @override
  String downloadsPeersConnected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pairs connectés',
      one: '1 pair connecté',
    );
    return '$_temp0';
  }

  @override
  String downloadsPeersSeeds(int peers, int seeds) {
    String _temp0 = intl.Intl.pluralLogic(
      peers,
      locale: localeName,
      other: '$peers pairs',
      one: '1 pair',
    );
    String _temp1 = intl.Intl.pluralLogic(
      seeds,
      locale: localeName,
      other: '$seeds sources',
      one: '1 source',
    );
    return '$_temp0 • $_temp1';
  }

  @override
  String downloadsSectionCompleted(int count) {
    return 'Terminés ($count)';
  }

  @override
  String downloadsSectionDownloading(int count) {
    return 'En cours ($count)';
  }

  @override
  String downloadsSectionFailed(int count) {
    return 'Échecs ($count)';
  }

  @override
  String downloadsSectionQueue(int count) {
    return 'File d\'attente ($count)';
  }

  @override
  String get filterApply => 'Appliquer les filtres';

  @override
  String get filterClearAll => 'Tout effacer';

  @override
  String get filterHasAchievements => 'Avec succès';

  @override
  String get filterPlatforms => 'Plateformes';

  @override
  String filterPlatformsError(String error) {
    return 'Erreur de chargement des plateformes : $error';
  }

  @override
  String get filterRegions => 'Régions';

  @override
  String filterRegionsError(String error) {
    return 'Erreur de chargement des régions : $error';
  }

  @override
  String get libraryAll => 'Tous';

  @override
  String get libraryCleanUp => 'Nettoyer';

  @override
  String get libraryCleanUpBody =>
      'Retirer les entrées dont les fichiers n\'existent plus ?';

  @override
  String get libraryCleanUpTitle => 'Nettoyer la bibliothèque';

  @override
  String get libraryCleanedUp => 'Bibliothèque nettoyée';

  @override
  String libraryDeleteConfirm(String title) {
    return 'Supprimer « $title » ?';
  }

  @override
  String get libraryDeleteFile => 'Supprimer le fichier';

  @override
  String get libraryDeleteTitle => 'Supprimer le jeu';

  @override
  String get libraryDeleted => 'Jeu supprimé';

  @override
  String get libraryEmpty => 'Ta bibliothèque est vide';

  @override
  String get libraryEmptyHint => 'Les jeux téléchargés apparaîtront ici';

  @override
  String get libraryFileMissing => 'Le fichier n\'existe plus';

  @override
  String get libraryFilesVerified => 'Fichiers vérifiés';

  @override
  String get libraryFormat => 'Format';

  @override
  String get libraryMissing => 'Manquant';

  @override
  String libraryNoPlatformRoms(String platform) {
    return 'Aucun jeu $platform';
  }

  @override
  String libraryNoResults(String query) {
    return 'Aucun résultat pour « $query »';
  }

  @override
  String libraryOpenError(String error) {
    return 'Impossible d\'ouvrir le fichier : $error';
  }

  @override
  String get libraryOpenWith => 'Ouvrir avec…';

  @override
  String get libraryPath => 'Chemin :';

  @override
  String get libraryPathNotFound => 'Chemin du fichier introuvable';

  @override
  String get libraryPlatform => 'Plateforme';

  @override
  String get libraryRemoveFromLibrary => 'Retirer de la bibliothèque';

  @override
  String get libraryRemoved => 'Retiré de la bibliothèque';

  @override
  String get librarySearchHint => 'Rechercher dans la bibliothèque…';

  @override
  String get librarySize => 'Taille';

  @override
  String libraryTabDownloaded(int count) {
    return 'Téléchargés ($count)';
  }

  @override
  String libraryTabWishlist(int count) {
    return 'Souhaits ($count)';
  }

  @override
  String get libraryVerifyFiles => 'Vérifier les fichiers';

  @override
  String get libraryWishlistEmpty => 'Ta liste de souhaits est vide';

  @override
  String get libraryWishlistError =>
      'Impossible de charger la liste de souhaits';

  @override
  String get libraryWishlistHint =>
      'Appuie sur le cœur d\'un jeu pour l\'ajouter ici';

  @override
  String get navBrowse => 'Parcourir';

  @override
  String get navDownloads => 'Téléchargements';

  @override
  String get navLibrary => 'Bibliothèque';

  @override
  String get navSettings => 'Réglages';

  @override
  String get statusCachingDebrid => 'Mise en cache sur le debrid…';

  @override
  String get statusCompleted => 'Terminé';

  @override
  String get statusDownloading => 'Téléchargement…';

  @override
  String get statusDownloadingTorrent => 'Téléchargement (torrent)';

  @override
  String get statusExtracting => 'Extraction…';

  @override
  String get statusFailed => 'Échec';

  @override
  String get statusFindingPeers => 'Recherche de pairs…';

  @override
  String get statusPaused => 'En pause';

  @override
  String get statusResolvingDebrid => 'Résolution via le debrid…';

  @override
  String get statusWaiting => 'En attente…';

  @override
  String get storagePermissionBody =>
      'Romgi a besoin d\'accéder au stockage pour enregistrer les ROM dans un dossier accessible à ton gestionnaire de fichiers et à tes émulateurs.\n\nSur l\'écran suivant, active « Autoriser l\'accès pour gérer tous les fichiers ».';

  @override
  String get storagePermissionTitle => 'Autorisation de stockage';

  @override
  String updateAvailableSnack(String version) {
    return 'Mise à jour disponible : v$version';
  }
}
