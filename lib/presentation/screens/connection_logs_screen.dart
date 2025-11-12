import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/connection_log_provider.dart';
import '../widgets/common/empty_state.dart';
import '../theme/spacing.dart';
import '../../data/database/app_database.dart';

/// Connection logs debug screen displaying BLE connection events.
class ConnectionLogsScreen extends ConsumerWidget {
  const ConnectionLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(connectionLogsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear Logs',
            onPressed: () => _confirmClearLogs(context, ref),
          ),
        ],
      ),
      body: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return const EmptyState(
              icon: Icons.info_outline,
              title: 'No Logs',
              message: 'Connection events will appear here when you connect to a device',
            );
          }

          return ListView.builder(
            reverse: true, // Newest at top
            padding: const EdgeInsets.all(AppSpacing.small),
            itemCount: logs.length,
            itemBuilder: (context, index) => _LogTile(log: logs[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: AppSpacing.medium),
              Text('Error loading logs: $error'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmClearLogs(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Logs?'),
        content: const Text('This will permanently delete all connection log entries. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        final dao = ref.read(connectionLogDaoProvider);
        await dao.deleteAllLogs();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logs cleared')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error clearing logs: $e')),
          );
        }
      }
    }
  }
}

class _LogTile extends StatefulWidget {
  final ConnectionLog log;

  const _LogTile({required this.log});

  @override
  State<_LogTile> createState() => _LogTileState();
}

class _LogTileState extends State<_LogTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logLevel = _parseLogLevel(widget.log.level);
    final logColor = _getLogLevelColor(theme, logLevel);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: ExpansionTile(
        leading: Icon(
          _getLogLevelIcon(logLevel),
          color: logColor,
        ),
        title: Text(
          widget.log.eventType,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          _formatTimestamp(widget.log.timestamp),
          style: theme.textTheme.bodySmall,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: logColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            logLevel.toUpperCase(),
            style: TextStyle(
              color: logColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.log.message.isNotEmpty) ...[
                  Text(
                    'Message:',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    widget.log.message,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                ],
                if (widget.log.metadata?.isNotEmpty ?? false) ...[
                  Text(
                    'Metadata:',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    widget.log.metadata ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
                if (widget.log.deviceName?.isNotEmpty ?? false) ...[
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    'Device: ${widget.log.deviceName}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                if (widget.log.deviceAddress?.isNotEmpty ?? false) ...[
                  Text(
                    'Address: ${widget.log.deviceAddress ?? ''}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                if (widget.log.details?.isNotEmpty ?? false) ...[
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    'Details: ${widget.log.details}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _parseLogLevel(String level) {
    final lower = level.toLowerCase();
    if (lower.contains('error')) return 'error';
    if (lower.contains('warn')) return 'warning';
    if (lower.contains('info')) return 'info';
    return 'debug';
  }

  Color _getLogLevelColor(ThemeData theme, String level) {
    switch (level) {
      case 'error':
        return theme.colorScheme.error;
      case 'warning':
        return Colors.orange;
      case 'info':
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.onSurfaceVariant;
    }
  }

  IconData _getLogLevelIcon(String level) {
    switch (level) {
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      case 'info':
        return Icons.info;
      default:
        return Icons.bug_report;
    }
  }

  String _formatTimestamp(BigInt timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
    return DateFormat('HH:mm:ss.SSS').format(dateTime);
  }
}

