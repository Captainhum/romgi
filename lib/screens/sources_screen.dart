import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/source.dart';
import '../providers/sources_provider.dart';
import '../l10n/l10n.dart';

class SourcesScreen extends ConsumerWidget {
  const SourcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSources = ref.watch(sourcesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsSources),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: context.l10n.commonRefresh,
            onPressed: () => ref.invalidate(sourcesProvider),
          ),
        ],
      ),
      body: asyncSources.when(
        data: (sources) {
          if (sources.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  context.l10n.sourcesEmpty,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: sources.length,
            separatorBuilder: (_, _) => const Divider(height: 0),
            itemBuilder: (context, i) => _SourceTile(source: sources[i]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(context.l10n.sourcesLoadError('$e')),
          ),
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({required this.source});

  final SourceInfo source;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasHomepage = source.homepage != null && source.homepage!.isNotEmpty;

    return ListTile(
      leading: _StatusDot(status: source.status),
      title: Text(
        source.name,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              _Chip(label: source.kind),
              if (source.authRequired)
                _Chip(label: context.l10n.sourcesLoginRequired),
              _Chip(label: context.l10n.sourcesPriority(source.priority)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            _statusLine(context.l10n, source),
            style: theme.textTheme.bodySmall,
          ),
          if (source.statusReason != null && source.statusReason!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                source.statusReason!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
        ],
      ),
      trailing: hasHomepage
          ? IconButton(
              icon: const Icon(Icons.open_in_new),
              tooltip: context.l10n.sourcesOpenHomepage(source.homepage!),
              onPressed: () => _open(source.homepage!),
            )
          : null,
      isThreeLine: true,
    );
  }

  static String _statusLine(AppLocalizations l10n, SourceInfo source) {
    final parts = <String>[];
    parts.add(_statusLabel(l10n, source.status));
    if (source.lastChecked != null) {
      parts.add(l10n.sourcesChecked(_relative(l10n, source.lastChecked!)));
    }
    if (source.entryCount != null && source.linkCount != null) {
      parts.add(
        l10n.sourcesCounts(
          _compact(source.entryCount!),
          _compact(source.linkCount!),
        ),
      );
    }
    return parts.join(' · ');
  }

  static String _statusLabel(AppLocalizations l10n, SourceStatus s) {
    switch (s) {
      case SourceStatus.ok:
        return 'OK';
      case SourceStatus.degraded:
        return l10n.sourcesStatusDegraded;
      case SourceStatus.down:
        return l10n.sourcesStatusDown;
      case SourceStatus.stale:
        return l10n.sourcesStatusStale;
      case SourceStatus.unknown:
        return l10n.commonUnknown;
    }
  }

  static String _relative(AppLocalizations l10n, DateTime when) {
    final delta = DateTime.now().toUtc().difference(when.toUtc());
    if (delta.inMinutes < 1) return l10n.timeJustNow;
    if (delta.inMinutes < 60) return l10n.timeMinutesAgo(delta.inMinutes);
    if (delta.inHours < 24) return l10n.timeHoursAgo(delta.inHours);
    final days = delta.inDays;
    if (days < 30) return l10n.timeDaysAgo(days);
    final months = (days / 30).floor();
    if (months < 12) return l10n.timeMonthsAgo(months);
    return l10n.timeYearsAgo((months / 12).floor());
  }

  static String _compact(int n) {
    if (n < 1000) return '$n';
    if (n < 1_000_000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '${(n / 1_000_000).toStringAsFixed(1)}M';
  }

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});

  final SourceStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (status) {
      SourceStatus.ok => Colors.green,
      SourceStatus.degraded => Colors.orange,
      SourceStatus.stale => Colors.amber,
      SourceStatus.down => theme.colorScheme.error,
      SourceStatus.unknown => theme.colorScheme.outline,
    };
    return Container(
      width: 14,
      height: 14,
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall,
      ),
    );
  }
}
