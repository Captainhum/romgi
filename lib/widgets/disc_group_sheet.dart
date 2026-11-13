import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import '../l10n/l10n.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/disc_organizer.dart';
import '../services/link_resolver.dart';

/// What the user confirmed in [DiscGroupSheet].
class DiscGroupChoice {
  const DiscGroupChoice({required this.links, required this.hidden});

  /// Chosen link per member slug; members without a source are absent.
  final Map<String, DownloadLink> links;
  final bool hidden;
}

class _DiscOption {
  _DiscOption(this.member, this.ranked)
      : selected = ranked.isEmpty ? null : ranked.first.link;

  final EntryGroupMember member;
  final List<ResolvedLink> ranked;
  DownloadLink? selected;
}

/// Opens the full-game sheet for [group], queues the confirmed discs and
/// reports the outcome in a snackbar.
Future<void> downloadDiscGroup(
  BuildContext context,
  WidgetRef ref,
  EntryGroup group, {
  required Map<String, int> sourcePriority,
}) async {
  final prefs = LinkResolverPrefs(
    isIaLoggedIn: await ref.read(iaLoggedInProvider.future),
    torrentsDisabled: ref.read(settingsProvider).torrentsDisabled,
  );
  if (!context.mounted) return;

  final choice = await showModalBottomSheet<DiscGroupChoice>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => DiscGroupSheet(
      group: group,
      prefs: prefs,
      sourcePriority: sourcePriority,
    ),
  );
  if (choice == null || !context.mounted) return;

  await ref.read(settingsProvider.notifier).setDiscHideDefault(choice.hidden);
  final result = await ref.read(downloadProvider.notifier).addDiscGroup(
        group,
        prefs: prefs,
        sourcePriority: sourcePriority,
        linkOverrides: choice.links,
        hidden: choice.hidden,
      );
  if (!context.mounted) return;

  final l10n = context.l10n;
  final parts = <String>[
    if (result.added > 0) l10n.detailDiscsQueued(result.added),
    if (result.duplicates > 0) l10n.detailDiscsDuplicate(result.duplicates),
    if (result.skipped > 0) l10n.detailDiscsUnavailable(result.skipped),
  ];
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(
          parts.isEmpty
              ? l10n.detailNoDiscsAvailable
              : l10n.detailDiscsSummary(parts.join(', ')),
        ),
        duration: const Duration(seconds: 5),
        action: result.added > 0
            ? SnackBarAction(
                label: l10n.commonView,
                onPressed: () {
                  ref.read(navigationTabProvider.notifier).state =
                      NavTab.downloads;
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            : null,
      ),
    );
}

/// Lists every disc of a set with its source and size, explains what will
/// be created, and returns a [DiscGroupChoice] when confirmed.
class DiscGroupSheet extends ConsumerStatefulWidget {
  const DiscGroupSheet({
    super.key,
    required this.group,
    required this.prefs,
    required this.sourcePriority,
  });

  final EntryGroup group;
  final LinkResolverPrefs prefs;
  final Map<String, int> sourcePriority;

  @override
  ConsumerState<DiscGroupSheet> createState() => _DiscGroupSheetState();
}

class _DiscGroupSheetState extends ConsumerState<DiscGroupSheet> {
  late final Future<(List<_DiscOption>, Directory)> _load = _loadOptions();
  late bool _hidden = ref.read(settingsProvider).discHideDefault;

  Future<(List<_DiscOption>, Directory)> _loadOptions() async {
    final romDb = ref.read(romDatabaseProvider);
    final resolver = LinkResolver(sourcePriority: widget.sourcePriority);
    final options = <_DiscOption>[];
    for (final member in widget.group.members) {
      final entry = await romDb.getEntry(member.slug);
      options.add(_DiscOption(
        member,
        entry == null ? const [] : resolver.rank(entry.links, widget.prefs),
      ));
    }
    final dir = await ref
        .read(storageServiceProvider)
        .getPlatformDirectory(widget.group.platform);
    return (options, dir);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return SafeArea(
      child: FutureBuilder<(List<_DiscOption>, Directory)>(
        future: _load,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.all(48),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final (options, dir) = snapshot.data!;
          final available = options.where((o) => o.selected != null);
          final totalBytes =
              available.fold<int>(0, (sum, o) => sum + o.selected!.size);
          final missing = options.length - available.length;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.sheetTitle(widget.group.title, options.length),
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                for (final option in options) _discRow(context, option),
                if (missing > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.sheetMissingDiscs(missing),
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ],
                const Divider(height: 32),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _hidden,
                  onChanged: (value) => setState(() => _hidden = value!),
                  title: Text(l10n.sheetHiddenOption),
                  subtitle: Text(l10n.sheetHiddenHelp),
                ),
                const SizedBox(height: 8),
                Text(l10n.sheetResultIn(dir.path),
                    style: theme.textTheme.labelLarge),
                const SizedBox(height: 4),
                _preview(context, options),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.commonCancel),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      icon: const Icon(Icons.download),
                      onPressed: available.isEmpty
                          ? null
                          : () => Navigator.pop(
                                context,
                                DiscGroupChoice(
                                  links: {
                                    for (final o in available)
                                      o.member.slug: o.selected!,
                                  },
                                  hidden: _hidden,
                                ),
                              ),
                      label: Text(l10n.sheetConfirm(
                        _formatSize(context, totalBytes),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _discRow(BuildContext context, _DiscOption option) {
    final l10n = context.l10n;
    final label = option.member.label.isEmpty
        ? l10n.detailDiscLabel(option.member.index)
        : option.member.label;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 96, child: Text(label)),
          Expanded(
            child: option.ranked.isEmpty
                ? Text(
                    l10n.sheetUnavailable,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  )
                : DropdownButton<DownloadLink>(
                    isExpanded: true,
                    value: option.selected,
                    onChanged: (link) =>
                        setState(() => option.selected = link),
                    items: [
                      for (final resolved in option.ranked)
                        DropdownMenuItem(
                          value: resolved.link,
                          child: Text(
                            '${resolved.link.host} · '
                            '${resolved.link.isTorrent ? l10n.detailTorrent : l10n.detailDirect}'
                            ' · ${resolved.link.sizeStr}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _preview(BuildContext context, List<_DiscOption> options) {
    final style = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(fontFamily: 'monospace');
    final discs = [
      for (final o in options)
        if (o.selected != null) p.basenameWithoutExtension(o.selected!.filename),
    ];
    final lines = _hidden
        ? [
            '${widget.group.title}.m3u',
            for (final d in discs) '${DiscOrganizer.hiddenDirName}/$d…',
          ]
        : [
            '${widget.group.title}.m3u',
            for (final d in discs) '$d…',
          ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(lines.join('\n'), style: style),
    );
  }

  String _formatSize(BuildContext context, int bytes) {
    final l10n = context.l10n;
    final format = NumberFormat.decimalPatternDigits(
      locale: Localizations.localeOf(context).toString(),
      decimalDigits: 1,
    );
    const gb = 1024 * 1024 * 1024;
    if (bytes >= gb) return l10n.sizeGb(format.format(bytes / gb));
    return l10n.sizeMb(format.format(bytes / (1024 * 1024)));
  }
}
