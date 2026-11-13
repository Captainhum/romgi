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
  String get commonDelete => 'Supprimer';

  @override
  String get commonDownload => 'Télécharger';

  @override
  String get commonDownloaded => 'Téléchargé';

  @override
  String get commonErrorOccurred => 'Une erreur est survenue';

  @override
  String get commonFilters => 'Filtres';

  @override
  String get commonLoading => 'Chargement…';

  @override
  String get commonRefresh => 'Actualiser';

  @override
  String get commonReload => 'Recharger';

  @override
  String get commonRemove => 'Supprimer';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonTryAgain => 'Réessayer';

  @override
  String get commonTryAgainTooltip => 'Réessayer';

  @override
  String get commonUnknown => 'Inconnu';

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
  String get errorCancelled => 'La requête a été annulée.';

  @override
  String get errorCannotConnect =>
      'Connexion impossible. Vérifie ta connexion internet.';

  @override
  String get errorCannotConnectServer =>
      'Impossible de joindre le serveur. Vérifie ta connexion internet.';

  @override
  String get errorConnectTimeout =>
      'Délai dépassé. Le serveur met trop de temps à répondre.';

  @override
  String get errorConnectionFailed => 'La connexion a échoué. Réessaie.';

  @override
  String get errorGeneric => 'Quelque chose s\'est mal passé. Réessaie.';

  @override
  String get errorHttp400 => 'Requête invalide. Réessaie.';

  @override
  String get errorHttp401 => 'Authentification requise.';

  @override
  String get errorHttp403 => 'Accès refusé.';

  @override
  String get errorHttp404 => 'Le contenu demandé est introuvable.';

  @override
  String get errorHttp429 =>
      'Trop de requêtes. Patiente un instant puis réessaie.';

  @override
  String get errorHttp500 =>
      'Erreur du serveur. Le service rencontre des problèmes.';

  @override
  String get errorHttp502 =>
      'Serveur temporairement indisponible. Réessaie plus tard.';

  @override
  String get errorHttp503 =>
      'Service actuellement indisponible. Réessaie plus tard.';

  @override
  String get errorHttp504 =>
      'Le serveur a mis trop de temps à répondre. Réessaie.';

  @override
  String get errorReceiveTimeout =>
      'Délai de réponse dépassé. Le serveur met trop de temps.';

  @override
  String get errorRequestFailed => 'La requête a échoué. Réessaie.';

  @override
  String get errorSecureConnection =>
      'La connexion sécurisée a échoué. Réessaie plus tard.';

  @override
  String get errorSendTimeout => 'Délai dépassé pendant l\'envoi des données.';

  @override
  String get errorServerLater => 'Erreur du serveur. Réessaie plus tard.';

  @override
  String get errorServerRetry => 'Erreur du serveur. Réessaie.';

  @override
  String get errorTimeoutSlow =>
      'Délai dépassé. Le serveur est peut-être lent ou indisponible.';

  @override
  String get errorTitle => 'Erreur';

  @override
  String get errorTitleConnection => 'Erreur de connexion';

  @override
  String get errorTitleServer => 'Erreur du serveur';

  @override
  String get errorTitleTimeout => 'Délai dépassé';

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
  String get iaCredentialsError =>
      'Impossible de récupérer les identifiants Internet Archive. Réessaie.';

  @override
  String get iaLoginTitle => 'Connexion Internet Archive';

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
  String get notifChannelComplete => 'Téléchargement terminé';

  @override
  String get notifChannelCompleteDesc =>
      'Prévient quand un téléchargement est terminé';

  @override
  String get notifChannelProgress => 'Progression des téléchargements';

  @override
  String get notifChannelProgressDesc =>
      'Affiche la progression des téléchargements';

  @override
  String get notifDownloading => 'Téléchargement';

  @override
  String get notifExtracting => 'Extraction';

  @override
  String get notifFailed => 'Échec du téléchargement';

  @override
  String get notifServiceChannel => 'Service de téléchargement';

  @override
  String get notifServiceChannelDesc =>
      'Garde les téléchargements actifs en arrière-plan';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsAccounts => 'Comptes';

  @override
  String get settingsApiKeyCleared => 'Clé API effacée';

  @override
  String get settingsApiKeySaved => 'Clé API enregistrée';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsAutoExtract => 'Extraction auto';

  @override
  String get settingsChecking => 'Vérification…';

  @override
  String get settingsChooseTheme => 'Choisir le thème';

  @override
  String get settingsCleanUpHint =>
      'Retirer les entrées des fichiers manquants';

  @override
  String settingsConcurrentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count téléchargements à la fois',
      one: '1 téléchargement à la fois',
    );
    return '$_temp0';
  }

  @override
  String get settingsConcurrentDownloads => 'Téléchargements simultanés';

  @override
  String get settingsConcurrentUnlimited =>
      'Téléchargements simultanés illimités';

  @override
  String get settingsConnected => 'Connexion réussie';

  @override
  String get settingsCredentialsCleared => 'Identifiants effacés';

  @override
  String get settingsCredentialsSaved => 'Identifiants enregistrés';

  @override
  String get settingsDatabaseDeleted => 'Base supprimée';

  @override
  String settingsDatabaseDownloadFailed(String error) {
    return 'Échec du téléchargement : $error';
  }

  @override
  String get settingsDatabaseDownloadPrompt =>
      'Télécharge la base de données pour parcourir et rechercher des jeux.';

  @override
  String get settingsDatabaseError => 'Erreur de lecture de la base';

  @override
  String get settingsDatabaseNewVersion =>
      'Une nouvelle version de la base est disponible.';

  @override
  String settingsDatabaseSize(String size) {
    return 'Taille : $size Mo';
  }

  @override
  String get settingsDatabaseUpdate => 'Mettre à jour la base';

  @override
  String get settingsDatabaseUpdated => 'Base mise à jour';

  @override
  String get settingsDatabaseUpdating => 'Mise à jour de la base';

  @override
  String settingsDatabaseVersion(String version, String entries) {
    return 'Version $version - $entries jeux';
  }

  @override
  String settingsDebridApiKey(String provider) {
    return 'Clé API $provider';
  }

  @override
  String get settingsDebridService => 'Service debrid';

  @override
  String get settingsDefaultLocation => 'Dossier par défaut';

  @override
  String get settingsDeleteDatabase => 'Supprimer la base';

  @override
  String get settingsDeleteDatabaseBody =>
      'La base de données des ROM sera supprimée. Il faudra la retélécharger pour parcourir le catalogue.\n\nÇa peut corriger une base corrompue.';

  @override
  String get settingsDeleteReset => 'Supprimer et réinitialiser';

  @override
  String get settingsDisableAutoExtract =>
      'Désactiver l\'extraction automatique';

  @override
  String get settingsDisableAutoExtractHint =>
      'Garder les archives téléchargées sans les extraire';

  @override
  String get settingsDisableTorrents => 'Désactiver les torrents';

  @override
  String get settingsDisableTorrentsHint =>
      'Utiliser uniquement les téléchargements directs (masque les sources torrent)';

  @override
  String get settingsDownloadLocations => 'Dossiers de téléchargement';

  @override
  String get settingsFieldApiKey => 'Clé API';

  @override
  String settingsFieldOptional(String label) {
    return '$label (facultatif)';
  }

  @override
  String get settingsFieldPassword => 'Mot de passe';

  @override
  String get settingsFieldUsername => 'Nom d\'utilisateur';

  @override
  String get settingsFillRequired => 'Remplis tous les champs obligatoires';

  @override
  String get settingsGameMetadata => 'Métadonnées des jeux';

  @override
  String get settingsIaLoginHint =>
      'Connecte-toi pour télécharger les fichiers protégés';

  @override
  String get settingsInstall => 'Installer';

  @override
  String settingsLoggedInAs(String username) {
    return 'Connecté en tant que $username';
  }

  @override
  String get settingsLoggedOut => 'Déconnecté d\'Internet Archive';

  @override
  String get settingsLogout => 'Déconnexion';

  @override
  String get settingsLogoutConfirm => 'Te déconnecter d\'Internet Archive ?';

  @override
  String get settingsMetadataSubtitle =>
      'Descriptions, captures et illustrations sur les fiches de jeux (ScreenScraper, SteamGridDB)';

  @override
  String get settingsNoApiKey => 'Aucune clé API enregistrée';

  @override
  String get settingsNoCredentials => 'Aucun identifiant enregistré';

  @override
  String get settingsNotInstalled => 'Non installée';

  @override
  String get settingsNotLoggedIn => 'Non connecté';

  @override
  String get settingsPlatformLocations => 'Dossiers par plateforme';

  @override
  String get settingsPlatformLocationsHint =>
      'Choisir un dossier différent pour certaines plateformes';

  @override
  String get settingsPlatformsError => 'Impossible de charger les plateformes';

  @override
  String get settingsProvider => 'Fournisseur';

  @override
  String get settingsRomDatabase => 'Base de données des ROM';

  @override
  String get settingsRomSources => 'Sources de ROM';

  @override
  String get settingsRomSourcesHint =>
      'État des catalogues qui alimentent l\'app';

  @override
  String get settingsSaveKey => 'Enregistrer la clé';

  @override
  String get settingsShowMetadata => 'Afficher les métadonnées';

  @override
  String get settingsSourceCode => 'Code source';

  @override
  String get settingsSources => 'Sources';

  @override
  String get settingsTest => 'Tester';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeSystem => 'Par défaut du système';

  @override
  String get settingsUpdate => 'Mettre à jour';

  @override
  String get settingsUseDebrid => 'Utiliser un service debrid';

  @override
  String get settingsUseDebridHint =>
      'Transformer les torrents en cache en liens directs rapides (TorBox, Real-Debrid)';

  @override
  String get settingsUsingDefault => 'Dossier par défaut';

  @override
  String get settingsVerifyFilesHint =>
      'Vérifier que les fichiers téléchargés existent toujours';

  @override
  String get settingsVersion => 'Version';

  @override
  String get setupChecking => 'Vérification de la base…';

  @override
  String get setupDownloadBody =>
      'La base du catalogue doit être téléchargée pour parcourir et rechercher des jeux.';

  @override
  String get setupDownloadButton => 'Télécharger la base';

  @override
  String get setupDownloadSize => 'Taille';

  @override
  String get setupDownloadTitle => 'Télécharger la base des ROM';

  @override
  String get setupDownloading => 'Téléchargement de la base…';

  @override
  String get setupFailed => 'Échec du téléchargement';

  @override
  String get setupReady => 'Base prête !';

  @override
  String get setupRomEntries => 'Jeux';

  @override
  String setupSizeMb(String size) {
    return '$size Mo';
  }

  @override
  String sourcesChecked(String when) {
    return 'vérifié $when';
  }

  @override
  String sourcesCounts(String entries, String links) {
    return '$entries jeux · $links liens';
  }

  @override
  String get sourcesEmpty =>
      'Aucune source dans la base du catalogue. Télécharge ou mets à jour la base depuis Réglages → Mettre à jour.';

  @override
  String sourcesLoadError(String error) {
    return 'Impossible de charger les sources : $error';
  }

  @override
  String get sourcesLoginRequired => 'connexion requise';

  @override
  String sourcesOpenHomepage(String url) {
    return 'Ouvrir $url';
  }

  @override
  String sourcesPriority(int priority) {
    return 'priorité $priority';
  }

  @override
  String get sourcesStatusDegraded => 'Dégradée';

  @override
  String get sourcesStatusDown => 'Hors service';

  @override
  String get sourcesStatusStale => 'Obsolète';

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
  String timeDaysAgo(int n) {
    return 'il y a $n j';
  }

  @override
  String timeHoursAgo(int n) {
    return 'il y a $n h';
  }

  @override
  String get timeJustNow => 'à l\'instant';

  @override
  String timeMinutesAgo(int n) {
    return 'il y a $n min';
  }

  @override
  String timeMonthsAgo(int n) {
    return 'il y a $n mois';
  }

  @override
  String timeYearsAgo(int n) {
    return 'il y a $n an(s)';
  }

  @override
  String get updateAvailable => 'Mise à jour disponible';

  @override
  String updateAvailableSnack(String version) {
    return 'Mise à jour disponible : v$version';
  }

  @override
  String get updateCheck => 'Rechercher des mises à jour';

  @override
  String get updateChecking => 'Recherche de mises à jour…';

  @override
  String get updateDownloading => 'Téléchargement de la mise à jour…';

  @override
  String updateDownloadingProgress(int progress) {
    return 'Téléchargement… $progress %';
  }

  @override
  String get updateFailed => 'Échec de la recherche de mise à jour';

  @override
  String get updatePleaseWait => 'Patiente…';

  @override
  String get updateReady => 'Prête à installer';

  @override
  String updateTapInstall(String version) {
    return 'Appuie sur Installer pour passer à la version $version';
  }

  @override
  String get updateTapToCheck => 'Appuie pour rechercher une nouvelle version';

  @override
  String updateVersionAvailable(String version) {
    return 'La version $version est disponible';
  }
}
