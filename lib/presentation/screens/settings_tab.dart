import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/preferences_provider.dart';
import '../widgets/settings/theme_toggle.dart';
import '../widgets/settings/color_scheme_picker.dart';
import '../theme/spacing.dart';
import '../../domain/models/weight_unit.dart';

/// Settings tab screen with appearance, workout preferences, debug, and about sections.
class SettingsTab extends ConsumerWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(userPreferencesProvider);
    final prefsActions = ref.watch(preferencesActionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          // Appearance Section
          _buildSection(
            context,
            title: 'Appearance',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Theme'),
                trailing: const ThemeToggle(),
              ),
              const SizedBox(height: AppSpacing.medium),
              const ColorSchemePicker(),
            ],
          ),

          const SizedBox(height: AppSpacing.large),

          // Workout Preferences Section
          _buildSection(
            context,
            title: 'Workout Preferences',
            children: prefsAsync.when(
              data: (prefs) => [
                SwitchListTile(
                  title: const Text('Stop at Top'),
                  subtitle: const Text('End rep at top position (contracted)'),
                  value: prefs.stopAtTop,
                  onChanged: (value) => prefsActions.setStopAtTop(value),
                ),
                SwitchListTile(
                  title: const Text('Autoplay Videos'),
                  subtitle: const Text('Automatically play exercise videos'),
                  value: prefs.autoplayEnabled,
                  onChanged: (value) => prefsActions.setAutoplayEnabled(value),
                ),
                SwitchListTile(
                  title: const Text('Enable Video Playback'),
                  subtitle: const Text('Show exercise videos'),
                  value: prefs.enableVideoPlayback,
                  onChanged: (value) => prefsActions.setEnableVideoPlayback(value),
                ),
                ListTile(
                  title: const Text('Weight Unit'),
                  subtitle: Text(prefs.weightUnit == WeightUnit.kg ? 'Kilograms (kg)' : 'Pounds (lb)'),
                  trailing: DropdownButton<WeightUnit>(
                    value: prefs.weightUnit,
                    items: const [
                      DropdownMenuItem(
                        value: WeightUnit.kg,
                        child: Text('Kilograms (kg)'),
                      ),
                      DropdownMenuItem(
                        value: WeightUnit.lb,
                        child: Text('Pounds (lb)'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        prefsActions.setWeightUnit(value);
                      }
                    },
                  ),
                ),
              ],
              loading: () => [
                const Center(child: CircularProgressIndicator()),
              ],
              error: (error, stack) => [
                ListTile(
                  title: Text('Error loading preferences: $error'),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.large),

          // Debug Section
          _buildSection(
            context,
            title: 'Debug',
            children: [
              ListTile(
                leading: const Icon(Icons.bug_report),
                title: const Text('Connection Logs'),
                subtitle: const Text('View BLE connection debug logs'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(Routes.connectionLogs),
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text('Clear Workout Data'),
                subtitle: const Text('Delete all workout history'),
                onTap: () => _showClearDataConfirmation(context, ref),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.large),

          // About Section
          _buildSection(
            context,
            title: 'About',
            children: [
              ListTile(
                title: const Text('App Version'),
                subtitle: const Text('0.1.0-alpha'),
              ),
              ListTile(
                title: const Text('Open Source Licenses'),
                subtitle: const Text('View third-party licenses'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Show licenses dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Licenses screen coming soon')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> children}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.small, bottom: AppSpacing.small),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Future<void> _showClearDataConfirmation(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Workout Data?'),
        content: const Text(
          'This will permanently delete all workout history, routines, and programs. '
          'This action cannot be undone.',
        ),
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
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // TODO: Implement clear workout data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Clear workout data functionality coming soon')),
      );
    }
  }
}
