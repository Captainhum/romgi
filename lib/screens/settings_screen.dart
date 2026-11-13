import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/providers.dart';
import '../services/metadata/metadata_provider.dart';
import '../services/rom_database_service.dart';
import '../services/storage_service.dart';
import '../utils/utils.dart';
import 'internet_archive_login_screen.dart';
import 'sources_screen.dart';
import '../l10n/l10n.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final platformsAsync = ref.watch(platformsProvider);
    final storage = ref.watch(storageServiceProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.navSettings)),
      body: settings.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Downloads Section
                _SectionHeader(title: context.l10n.navDownloads),

                ListTile(
                  leading: const Icon(Icons.download),
                  title: Text(context.l10n.settingsConcurrentDownloads),
                  subtitle: Text(
                    settings.maxConcurrentDownloads == 0
                        ? context.l10n.settingsConcurrentUnlimited
                        : context.l10n.settingsConcurrentCount(
                            settings.maxConcurrentDownloads,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text('1'),
                      Expanded(
                        child: Slider(
                          // Map: 0 (unlimited) displays at position 11, 1-10 display at 1-10
                          value: settings.maxConcurrentDownloads == 0
                              ? 11
                              : settings.maxConcurrentDownloads.toDouble(),
                          min: 1,
                          max: 11,
                          divisions: 10,
                          label: settings.maxConcurrentDownloads == 0
                              ? '∞'
                              : '${settings.maxConcurrentDownloads}',
                          onChanged: (value) {
                            // Map: position 11 saves as 0 (unlimited), 1-10 save as 1-10
                            final intValue = value.round();
                            ref
                                .read(settingsProvider.notifier)
                                .setMaxConcurrentDownloads(
                                  intValue > 10 ? 0 : intValue,
                                );
                          },
                        ),
                      ),
                      const Text('∞'),
                    ],
                  ),
                ),

                SwitchListTile(
                  secondary: const Icon(Icons.block),
                  title: Text(context.l10n.settingsDisableTorrents),
                  subtitle: Text(
                    context.l10n.settingsDisableTorrentsHint,
                  ),
                  value: settings.torrentsDisabled,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setTorrentsDisabled(value);
                  },
                ),

                SwitchListTile(
                  secondary: const Icon(Icons.unarchive),
                  title: Text(context.l10n.settingsDisableAutoExtract),
                  subtitle: Text(
                    context.l10n.settingsDisableAutoExtractHint,
                  ),
                  value: settings.autoExtractDisabled,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setAutoExtractDisabled(value);
                  },
                ),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.settingsDebridService),
                const _DebridSection(),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.settingsGameMetadata),
                const _MetadataSection(),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.settingsDownloadLocations),

                FutureBuilder<String>(
                  future: storage.getDownloadDirectory().then((d) => d.path),
                  builder: (context, snapshot) {
                    final currentPath =
                        settings.defaultDownloadPath ??
                        snapshot.data ??
                        context.l10n.commonLoading;
                    return ListTile(
                      leading: const Icon(Icons.folder),
                      title: Text(context.l10n.settingsDefaultLocation),
                      subtitle: Text(
                        currentPath,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: settings.defaultDownloadPath != null
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                ref
                                    .read(settingsProvider.notifier)
                                    .setDefaultDownloadPath(null);
                              },
                            )
                          : null,
                      onTap: () => _pickFolder(context, ref, storage),
                    );
                  },
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    context.l10n.settingsPlatformLocations,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.l10n.settingsPlatformLocationsHint,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 8),
                platformsAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stackTrace) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      context.l10n.settingsPlatformsError,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  data: (platforms) {
                    final sorted = List.of(platforms)
                      ..sort(
                        (a, b) => PlatformNames.getDisplayName(
                          a.id,
                        ).compareTo(PlatformNames.getDisplayName(b.id)),
                      );
                    return Column(
                      children: sorted.map((platform) {
                        final customPath = settings.platformPaths[platform.id];
                        final extractEnabled =
                            settings.shouldExtractForPlatform(platform.id);
                        return ListTile(
                          leading: const Icon(Icons.folder_outlined),
                          title: Text(
                            PlatformNames.getDisplayName(platform.id),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customPath ?? context.l10n.settingsUsingDefault,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 36,
                                    child: FittedBox(
                                      child: Switch(
                                        value: extractEnabled,
                                        onChanged: settings.autoExtractDisabled
                                            ? null
                                            : (value) {
                                                ref
                                                    .read(settingsProvider
                                                        .notifier)
                                                    .setPlatformExtractDisabled(
                                                        platform.id, !value);
                                              },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    context.l10n.settingsAutoExtract,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: settings.autoExtractDisabled
                                              ? Colors.grey
                                              : null,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: customPath != null
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    ref
                                        .read(settingsProvider.notifier)
                                        .setPlatformPath(platform.id, null);
                                    storage.setPlatformPath(platform.id, null);
                                  },
                                )
                              : const Icon(Icons.chevron_right),
                          isThreeLine: true,
                          onTap: () => _pickFolder(
                            context,
                            ref,
                            storage,
                            platformId: platform.id,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.settingsAppearance),

                ListTile(
                  leading: const Icon(Icons.brightness_6),
                  title: Text(context.l10n.settingsTheme),
                  subtitle: Text(_getThemeModeName(context.l10n, settings.themeMode)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      _showThemePicker(context, ref, settings.themeMode),
                ),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.navLibrary),

                ListTile(
                  leading: const Icon(Icons.verified),
                  title: Text(context.l10n.libraryVerifyFiles),
                  subtitle: Text(context.l10n.settingsVerifyFilesHint),
                  onTap: () async {
                    await ref.read(libraryProvider.notifier).verifyFiles();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(context.l10n.libraryFilesVerified)),
                      );
                    }
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.cleaning_services),
                  title: Text(context.l10n.libraryCleanUpTitle),
                  subtitle: Text(context.l10n.settingsCleanUpHint),
                  onTap: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(context.l10n.libraryCleanUpTitle),
                        content: Text(
                          context.l10n.libraryCleanUpBody,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(context.l10n.commonCancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(context.l10n.libraryCleanUp),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await ref
                          .read(libraryProvider.notifier)
                          .cleanupMissingFiles();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l10n.libraryCleanedUp)),
                        );
                      }
                    }
                  },
                ),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.settingsAccounts),

                _InternetArchiveAccountTile(),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.settingsSources),

                ListTile(
                  leading: const Icon(Icons.cloud_outlined),
                  title: Text(context.l10n.settingsRomSources),
                  subtitle: Text(
                    context.l10n.settingsRomSourcesHint,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SourcesScreen(),
                    ),
                  ),
                ),

                const Divider(height: 32),

                _SectionHeader(title: context.l10n.settingsAbout),

                const _VersionTile(),

                const _UpdateTile(),

                const _DatabaseInfoTile(),

                ListTile(
                  leading: const Icon(Icons.code),
                  title: Text(context.l10n.settingsSourceCode),
                  subtitle: const Text('github.com/caprado/romgi'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => launchUrl(
                    Uri.parse('https://github.com/caprado/romgi'),
                    mode: LaunchMode.externalApplication,
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
    );
  }

  String _getThemeModeName(AppLocalizations l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return l10n.settingsThemeSystem;
      case AppThemeMode.light:
        return l10n.settingsThemeLight;
      case AppThemeMode.dark:
        return l10n.settingsThemeDark;
    }
  }

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    AppThemeMode currentMode,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.settingsChooseTheme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppThemeMode.values.map((mode) {
            final isSelected = mode == currentMode;
            return ListTile(
              leading: Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected
                    ? Theme.of(dialogContext).colorScheme.primary
                    : null,
              ),
              title: Text(_getThemeModeName(context.l10n, mode)),
              onTap: () {
                ref.read(settingsProvider.notifier).setThemeMode(mode);
                Navigator.pop(dialogContext);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _pickFolder(
    BuildContext context,
    WidgetRef ref,
    StorageService storage, {
    String? platformId,
  }) async {
    final result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      if (platformId != null) {
        // Platform-specific path
        ref.read(settingsProvider.notifier).setPlatformPath(platformId, result);
        storage.setPlatformPath(platformId, result);
      } else {
        // Default path
        ref.read(settingsProvider.notifier).setDefaultDownloadPath(result);
        storage.setCustomDownloadPath(result);
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _VersionTile extends ConsumerWidget {
  const _VersionTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionAsync = ref.watch(currentVersionProvider);

    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: Text(context.l10n.settingsVersion),
      subtitle: versionAsync.when(
        loading: () => Text(context.l10n.commonLoading),
        error: (error, stackTrace) => Text(context.l10n.commonUnknown),
        data: (version) => Text(version),
      ),
    );
  }
}

class _UpdateTile extends ConsumerWidget {
  const _UpdateTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateState = ref.watch(updateProvider);

    return Column(
      children: [
        ListTile(
          leading: Icon(
            _getUpdateIcon(updateState.status),
            color: _getUpdateColor(context, updateState.status),
          ),
          title: Text(_getUpdateTitle(context.l10n, updateState.status)),
          subtitle: Text(_getUpdateSubtitle(context.l10n, updateState)),
          trailing: _buildTrailingWidget(context, ref, updateState),
          onTap:
              updateState.status == UpdateStatus.idle ||
                  updateState.status == UpdateStatus.error
              ? () => ref.read(updateProvider.notifier).checkForUpdate()
              : null,
        ),
        if (updateState.status == UpdateStatus.downloading)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(value: updateState.downloadProgress),
          ),
      ],
    );
  }

  IconData _getUpdateIcon(UpdateStatus status) {
    switch (status) {
      case UpdateStatus.idle:
        return Icons.system_update;
      case UpdateStatus.checking:
        return Icons.refresh;
      case UpdateStatus.available:
        return Icons.download;
      case UpdateStatus.downloading:
        return Icons.downloading;
      case UpdateStatus.readyToInstall:
        return Icons.install_mobile;
      case UpdateStatus.error:
        return Icons.error_outline;
    }
  }

  Color? _getUpdateColor(BuildContext context, UpdateStatus status) {
    switch (status) {
      case UpdateStatus.available:
      case UpdateStatus.readyToInstall:
        return Theme.of(context).colorScheme.primary;
      case UpdateStatus.error:
        return Theme.of(context).colorScheme.error;
      default:
        return null;
    }
  }

  String _getUpdateTitle(AppLocalizations l10n, UpdateStatus status) {
    switch (status) {
      case UpdateStatus.idle:
        return l10n.updateCheck;
      case UpdateStatus.checking:
        return l10n.updateChecking;
      case UpdateStatus.available:
        return l10n.updateAvailable;
      case UpdateStatus.downloading:
        return l10n.updateDownloading;
      case UpdateStatus.readyToInstall:
        return l10n.updateReady;
      case UpdateStatus.error:
        return l10n.updateFailed;
    }
  }

  String _getUpdateSubtitle(AppLocalizations l10n, UpdateState state) {
    switch (state.status) {
      case UpdateStatus.idle:
        return l10n.updateTapToCheck;
      case UpdateStatus.checking:
        return l10n.updatePleaseWait;
      case UpdateStatus.available:
        return l10n.updateVersionAvailable(state.availableUpdate?.version ?? '');
      case UpdateStatus.downloading:
        final progress = (state.downloadProgress * 100).toInt();
        return l10n.updateDownloadingProgress(progress);
      case UpdateStatus.readyToInstall:
        return l10n.updateTapInstall(state.availableUpdate?.version ?? '');
      case UpdateStatus.error:
        return state.errorMessage ?? l10n.commonErrorOccurred;
    }
  }

  Widget? _buildTrailingWidget(
    BuildContext context,
    WidgetRef ref,
    UpdateState state,
  ) {
    switch (state.status) {
      case UpdateStatus.checking:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case UpdateStatus.available:
        return ElevatedButton(
          onPressed: () => ref.read(updateProvider.notifier).downloadUpdate(),
          child: Text(context.l10n.commonDownload),
        );
      case UpdateStatus.downloading:
        return IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => ref.read(updateProvider.notifier).cancelDownload(),
        );
      case UpdateStatus.readyToInstall:
        return ElevatedButton(
          onPressed: () => ref.read(updateProvider.notifier).installUpdate(),
          child: Text(context.l10n.settingsInstall),
        );
      case UpdateStatus.error:
        return IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.read(updateProvider.notifier).checkForUpdate(),
        );
      default:
        return const Icon(Icons.chevron_right);
    }
  }
}

class _InternetArchiveAccountTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedInAsync = ref.watch(iaLoggedInProvider);
    final usernameAsync = ref.watch(iaUsernameProvider);

    return isLoggedInAsync.when(
      loading: () => ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('Internet Archive'),
        subtitle: Text(context.l10n.settingsChecking),
      ),
      error: (error, stackTrace) => ListTile(
        leading: const Icon(Icons.account_circle),
        title: const Text('Internet Archive'),
        subtitle: Text(context.l10n.settingsNotLoggedIn),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openLogin(context, ref),
      ),
      data: (isLoggedIn) {
        if (isLoggedIn) {
          final username = usernameAsync.valueOrNull ?? context.l10n.commonUnknown;
          return ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Internet Archive'),
            subtitle: Text(context.l10n.settingsLoggedInAs(username)),
            trailing: TextButton(
              onPressed: () => _logout(context, ref),
              child: Text(context.l10n.settingsLogout),
            ),
          );
        } else {
          return ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Internet Archive'),
            subtitle: Text(context.l10n.settingsIaLoginHint),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openLogin(context, ref),
          );
        }
      },
    );
  }

  void _openLogin(BuildContext context, WidgetRef ref) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InternetArchiveLoginScreen(),
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.settingsLogout),
        content: Text(
          context.l10n.settingsLogoutConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.settingsLogout),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final authService = ref.read(internetArchiveAuthProvider);
      await authService.logout();
      ref.invalidate(iaLoggedInProvider);
      ref.invalidate(iaUsernameProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsLoggedOut)),
        );
      }
    }
  }
}

/// Provider to get local database version info
final localDbVersionProvider = FutureProvider<DatabaseVersion?>((ref) async {
  final dbService = ref.read(romDatabaseProvider);
  return dbService.getLocalVersion();
});

/// Provider to check for database updates
final dbUpdateAvailableProvider = FutureProvider<DatabaseVersion?>((ref) async {
  final dbService = ref.read(romDatabaseProvider);
  return dbService.checkForUpdate();
});

class _DatabaseInfoTile extends ConsumerWidget {
  const _DatabaseInfoTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localVersionAsync = ref.watch(localDbVersionProvider);
    final updateAvailableAsync = ref.watch(dbUpdateAvailableProvider);

    return localVersionAsync.when(
      loading: () => ListTile(
        leading: Icon(Icons.storage),
        title: Text(context.l10n.settingsRomDatabase),
        subtitle: Text(context.l10n.commonLoading),
      ),
      error: (error, stack) => ListTile(
        leading: const Icon(Icons.storage),
        title: Text(context.l10n.settingsRomDatabase),
        subtitle: Text(context.l10n.settingsDatabaseError),
        trailing: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.invalidate(localDbVersionProvider),
        ),
      ),
      data: (localVersion) {
        if (localVersion == null) {
          return ListTile(
            leading: const Icon(Icons.storage),
            title: Text(context.l10n.settingsRomDatabase),
            subtitle: Text(context.l10n.settingsNotInstalled),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton(
                  onPressed: () => _showUpdateDialog(context, ref, null),
                  child: Text(context.l10n.commonDownload),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'delete') {
                      _confirmDelete(context, ref);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: const Icon(Icons.delete_outline, color: Colors.red),
                        title: Text(context.l10n.settingsDeleteReset),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        final hasUpdate = updateAvailableAsync.valueOrNull != null;

        return ListTile(
          leading: Icon(
            Icons.storage,
            color: hasUpdate ? Theme.of(context).colorScheme.primary : null,
          ),
          title: Text(context.l10n.settingsRomDatabase),
          subtitle: Text(
            context.l10n.settingsDatabaseVersion(
              localVersion.version,
              _formatNumber(localVersion.entries),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasUpdate)
                FilledButton(
                  onPressed: () => _showUpdateDialog(
                    context,
                    ref,
                    updateAvailableAsync.valueOrNull,
                  ),
                  child: Text(context.l10n.settingsUpdate),
                )
              else
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    ref.invalidate(localDbVersionProvider);
                    ref.invalidate(dbUpdateAvailableProvider);
                  },
                ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'delete') {
                    _confirmDelete(context, ref);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: const Icon(Icons.delete_outline, color: Colors.red),
                      title: Text(context.l10n.settingsDeleteDatabase),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.settingsDeleteDatabase),
        content: Text(
          context.l10n.settingsDeleteDatabaseBody,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final dbService = ref.read(romDatabaseProvider);
      await dbService.deleteDatabase();
      ref.invalidate(localDbVersionProvider);
      ref.invalidate(dbUpdateAvailableProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsDatabaseDeleted)),
        );
      }
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    }
    return number.toString();
  }

  void _showUpdateDialog(
    BuildContext context,
    WidgetRef ref,
    DatabaseVersion? newVersion,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _DatabaseUpdateDialog(newVersion: newVersion),
    ).then((_) {
      // Refresh providers after dialog closes
      ref.invalidate(localDbVersionProvider);
      ref.invalidate(dbUpdateAvailableProvider);
    });
  }
}

class _DatabaseUpdateDialog extends ConsumerStatefulWidget {
  final DatabaseVersion? newVersion;

  const _DatabaseUpdateDialog({this.newVersion});

  @override
  ConsumerState<_DatabaseUpdateDialog> createState() =>
      _DatabaseUpdateDialogState();
}

class _DatabaseUpdateDialogState extends ConsumerState<_DatabaseUpdateDialog> {
  bool _isDownloading = false;
  double _progress = 0.0;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _isDownloading
            ? context.l10n.settingsDatabaseUpdating
            : context.l10n.settingsDatabaseUpdate,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_error != null) ...[
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 16),
          ],
          if (_isDownloading) ...[
            LinearProgressIndicator(value: _progress),
            const SizedBox(height: 8),
            Text('${(_progress * 100).toInt()}%'),
          ] else if (widget.newVersion != null) ...[
            Text(
              context.l10n.settingsDatabaseNewVersion,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.settingsDatabaseSize(
                (widget.newVersion!.size / 1024 / 1024).toStringAsFixed(1),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ] else ...[
            Text(context.l10n.settingsDatabaseDownloadPrompt),
          ],
        ],
      ),
      actions: [
        if (!_isDownloading)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
        if (!_isDownloading)
          FilledButton(
            onPressed: _startDownload,
            child: Text(context.l10n.commonDownload),
          ),
      ],
    );
  }

  Future<void> _startDownload() async {
    setState(() {
      _isDownloading = true;
      _progress = 0.0;
      _error = null;
    });

    try {
      final dbService = RomDatabaseService();
      await dbService.downloadDatabase(
        onProgress: (progress) {
          setState(() {
            _progress = progress;
          });
        },
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsDatabaseUpdated)),
        );
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _error = context.l10n.settingsDatabaseDownloadFailed('$e');
      });
    }
  }
}

class _MetadataSection extends ConsumerWidget {
  const _MetadataSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final providers = ref.read(gameMetadataServiceProvider).registry.providers;

    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.image_outlined),
          title: Text(context.l10n.settingsShowMetadata),
          subtitle: Text(
            context.l10n.settingsMetadataSubtitle,
          ),
          value: settings.metadataEnabled,
          onChanged: (value) =>
              ref.read(settingsProvider.notifier).setMetadataEnabled(value),
        ),
        if (settings.metadataEnabled)
          ...providers.map(
            (provider) => _MetadataProviderTile(provider: provider),
          ),
      ],
    );
  }
}

class _MetadataProviderTile extends ConsumerStatefulWidget {
  final GameMetadataProvider provider;

  const _MetadataProviderTile({required this.provider});

  @override
  ConsumerState<_MetadataProviderTile> createState() =>
      _MetadataProviderTileState();
}

class _MetadataProviderTileState extends ConsumerState<_MetadataProviderTile> {
  late final Map<String, TextEditingController> _controllers = {
    for (final field in widget.provider.credentialFields)
      field.key: TextEditingController(),
  };
  late final Map<String, bool> _obscure = {
    for (final field in widget.provider.credentialFields)
      field.key: field.obscure,
  };
  bool _testing = false;
  String? _message;

  String get _providerId => widget.provider.info.id;

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _invalidateConfigured() {
    ref.invalidate(metadataConfiguredProvider);
    ref.invalidate(metadataProviderConfiguredProvider(_providerId));
  }

  Future<void> _save() async {
    final credentials = {
      for (final entry in _controllers.entries)
        entry.key: entry.value.text.trim(),
    };
    final missing = widget.provider.credentialFields.any(
      (field) => !field.optional && (credentials[field.key] ?? '').isEmpty,
    );
    if (missing) {
      setState(() => _message = context.l10n.settingsFillRequired);
      return;
    }
    await ref.read(gameMetadataServiceProvider).setCredentials(
          providerId: _providerId,
          credentials: credentials,
        );
    for (final controller in _controllers.values) {
      controller.clear();
    }
    _invalidateConfigured();
    if (mounted) setState(() => _message = context.l10n.settingsCredentialsSaved);
  }

  Future<void> _test() async {
    setState(() {
      _testing = true;
      _message = null;
    });
    final error =
        await ref.read(gameMetadataServiceProvider).testConnection(_providerId);
    if (!mounted) return;
    setState(() {
      _testing = false;
      _message = error ?? context.l10n.settingsConnected;
    });
  }

  Future<void> _clear() async {
    await ref.read(gameMetadataServiceProvider).clearCredentials(_providerId);
    _invalidateConfigured();
    if (mounted) setState(() => _message = context.l10n.settingsCredentialsCleared);
  }

  @override
  Widget build(BuildContext context) {
    final configured =
        ref.watch(metadataProviderConfiguredProvider(_providerId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            widget.provider.info.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        for (final field in widget.provider.credentialFields)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _controllers[field.key],
              obscureText: _obscure[field.key]!,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText:
                    field.optional
                        ? context.l10n.settingsFieldOptional(
                            _fieldLabel(context.l10n, field),
                          )
                        : _fieldLabel(context.l10n, field),
                border: const OutlineInputBorder(),
                suffixIcon: field.obscure
                    ? IconButton(
                        icon: Icon(
                          _obscure[field.key]!
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => setState(
                          () => _obscure[field.key] = !_obscure[field.key]!,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              FilledButton(onPressed: _save, child: Text(context.l10n.commonSave)),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: _testing ? null : _test,
                child: _testing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(context.l10n.settingsTest),
              ),
              const Spacer(),
              configured.maybeWhen(
                data: (ok) => ok
                    ? TextButton(onPressed: _clear, child: Text(context.l10n.commonClear))
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        configured.maybeWhen(
          data: (ok) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Icon(
                  ok ? Icons.check_circle : Icons.info_outline,
                  size: 16,
                  color: ok
                      ? Colors.green
                      : Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 6),
                Text(
                  ok ? context.l10n.settingsCredentialsSaved : context.l10n.settingsNoCredentials,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        ),
        if (_message != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              _message!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

class _DebridSection extends ConsumerStatefulWidget {
  const _DebridSection();

  @override
  ConsumerState<_DebridSection> createState() => _DebridSectionState();
}

class _DebridSectionState extends ConsumerState<_DebridSection> {
  final _keyController = TextEditingController();
  bool _obscure = true;
  bool _testing = false;
  String? _message;

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  Future<void> _saveKey() async {
    final key = _keyController.text.trim();
    if (key.isEmpty) return;
    final providerId = ref.read(settingsProvider).debridProviderId;
    await ref
        .read(debridServiceProvider)
        .setCredentials(providerId: providerId, apiKey: key);
    _keyController.clear();
    ref.invalidate(debridConfiguredProvider);
    if (mounted) setState(() => _message = context.l10n.settingsApiKeySaved);
  }

  Future<void> _test() async {
    setState(() {
      _testing = true;
      _message = null;
    });
    final error = await ref.read(debridServiceProvider).testConnection();
    if (!mounted) return;
    setState(() {
      _testing = false;
      _message = error ?? context.l10n.settingsConnected;
    });
  }

  Future<void> _clear() async {
    await ref.read(debridServiceProvider).clearCredentials();
    ref.invalidate(debridConfiguredProvider);
    if (mounted) setState(() => _message = context.l10n.settingsApiKeyCleared);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final providers = ref.read(debridServiceProvider).registry.available;
    final configured = ref.watch(debridConfiguredProvider);
    final selected = providers.firstWhere(
      (p) => p.id == settings.debridProviderId,
      orElse: () => providers.first,
    );

    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.bolt),
          title: Text(context.l10n.settingsUseDebrid),
          subtitle: Text(
            context.l10n.settingsUseDebridHint,
          ),
          value: settings.debridEnabled,
          onChanged: (value) =>
              ref.read(settingsProvider.notifier).setDebridEnabled(value),
        ),
        if (settings.debridEnabled) ...[
          ListTile(
            leading: const Icon(Icons.cloud_outlined),
            title: Text(context.l10n.settingsProvider),
            trailing: DropdownButton<String>(
              value: settings.debridProviderId,
              items: providers
                  .map((p) =>
                      DropdownMenuItem(value: p.id, child: Text(p.name)))
                  .toList(),
              onChanged: (id) {
                if (id != null) {
                  ref.read(settingsProvider.notifier).setDebridProviderId(id);
                  setState(() => _message = null);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _keyController,
              obscureText: _obscure,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: context.l10n.settingsDebridApiKey(selected.name),
                helperText: selected.apiKeyHelp,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilledButton(
                    onPressed: _saveKey, child: Text(context.l10n.settingsSaveKey)),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _testing ? null : _test,
                  child: _testing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(context.l10n.settingsTest),
                ),
                const Spacer(),
                configured.maybeWhen(
                  data: (ok) => ok
                      ? TextButton(
                          onPressed: _clear, child: Text(context.l10n.commonClear))
                      : const SizedBox.shrink(),
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          configured.maybeWhen(
            data: (ok) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Icon(
                    ok ? Icons.check_circle : Icons.info_outline,
                    size: 16,
                    color: ok
                        ? Colors.green
                        : Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    ok ? context.l10n.settingsApiKeySaved : context.l10n.settingsNoApiKey,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
          if (_message != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                _message!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
      ],
    );
  }
}

String _fieldLabel(AppLocalizations l10n, CredentialField field) {
  switch (field.key) {
    case 'username':
      return l10n.settingsFieldUsername;
    case 'password':
      return l10n.settingsFieldPassword;
    case 'apiKey':
      return l10n.settingsFieldApiKey;
    default:
      return field.label;
  }
}
