import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/preferences_provider.dart';
import '../theme/spacing.dart';
import '../widgets/settings/settings_section_header.dart';
import '../widgets/settings/settings_section_card.dart';
import '../widgets/settings/setting_switch_row.dart';
import '../widgets/settings/weight_unit_selector.dart';
import '../widgets/settings/color_scheme_list.dart';
import '../widgets/dialogs/delete_confirmation_dialog.dart';
import '../../domain/models/user_preferences.dart';

/// Settings tab screen
///
/// Ported from Kotlin SettingsScreen.kt to exactly match the original implementation.
/// Contains 6 card sections: Weight Unit, Workout Preferences, LED Color Scheme,
/// Data Management, Developer Tools, and App Info.
class SettingsTab extends ConsumerStatefulWidget {
  const SettingsTab({super.key});

  @override
  ConsumerState<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends ConsumerState<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final preferencesAsync = ref.watch(userPreferencesProvider);
    final preferencesActions = ref.watch(preferencesActionsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppSpacing.medium),

            // Weight Unit Section
            _buildWeightUnitSection(preferencesAsync, preferencesActions),
            const SizedBox(height: AppSpacing.medium),

            // Workout Preferences Section
            _buildWorkoutPreferencesSection(preferencesAsync, preferencesActions),
            const SizedBox(height: AppSpacing.medium),

            // LED Color Scheme Section
            _buildColorSchemeSection(preferencesActions),
            const SizedBox(height: AppSpacing.medium),

            // Data Management Section
            _buildDataManagementSection(preferencesActions),
            const SizedBox(height: AppSpacing.medium),

            // Developer Tools Section
            _buildDeveloperToolsSection(),
            const SizedBox(height: AppSpacing.medium),

            // App Info Section
            _buildAppInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightUnitSection(
    AsyncValue<UserPreferences> preferencesAsync,
    PreferencesActions actions,
  ) {
    return SettingsSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSectionHeader(
            icon: Icons.scale,
            gradientColors: const [
              Color(0xFF8B5CF6),
              Color(0xFF9333EA),
            ],
            title: 'Weight Unit',
          ),
          const SizedBox(height: AppSpacing.small),
          preferencesAsync.when(
            data: (prefs) => WeightUnitSelector(
              selectedUnit: prefs.weightUnit,
              onChanged: (unit) => actions.setWeightUnit(unit),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutPreferencesSection(
    AsyncValue<UserPreferences> preferencesAsync,
    PreferencesActions actions,
  ) {
    return SettingsSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSectionHeader(
            icon: Icons.tune,
            gradientColors: const [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
            ],
            title: 'Workout Preferences',
          ),
          const SizedBox(height: AppSpacing.small),
          preferencesAsync.when(
            data: (prefs) => Column(
              children: [
                SettingSwitchRow(
                  label: 'Autoplay Routines',
                  description: 'Automatically advance to next exercise after rest timer',
                  value: prefs.autoplayEnabled,
                  onChanged: (value) => actions.setAutoplayEnabled(value),
                ),
                const SizedBox(height: AppSpacing.medium),
                SettingSwitchRow(
                  label: 'Stop At Top',
                  description: 'Release tension at contracted position instead of extended position',
                  value: prefs.stopAtTop,
                  onChanged: (value) => actions.setStopAtTop(value),
                ),
                const SizedBox(height: AppSpacing.medium),
                SettingSwitchRow(
                  label: 'Show Exercise Videos',
                  description: 'Display exercise demonstration videos (disable to avoid slow loading)',
                  value: prefs.enableVideoPlayback,
                  onChanged: (value) => actions.setEnableVideoPlayback(value),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSchemeSection(PreferencesActions actions) {
    return SettingsSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSectionHeader(
            icon: Icons.color_lens,
            gradientColors: const [
              Color(0xFF3B82F6),
              Color(0xFF6366F1),
            ],
            title: 'LED Color Scheme',
          ),
          const SizedBox(height: AppSpacing.small),
          ColorSchemeList(
            onColorSelected: (index) {
              actions.sendColorSchemeCommand(index).catchError((error) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to set color scheme: $error'),
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataManagementSection(PreferencesActions actions) {
    return SettingsSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSectionHeader(
            icon: Icons.delete_forever,
            gradientColors: const [
              Color(0xFFF97316),
              Color(0xFFEF4444),
            ],
            title: 'Data Management',
          ),
          const SizedBox(height: AppSpacing.small),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _showDeleteConfirmation(context, actions),
              icon: const Icon(Icons.delete, size: 18.0),
              label: const Text('Delete All Workouts'),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperToolsSection() {
    return SettingsSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSectionHeader(
            icon: Icons.bug_report,
            gradientColors: const [
              Color(0xFFF59E0B),
              Color(0xFFEF4444),
            ],
            title: 'Developer Tools',
          ),
          const SizedBox(height: AppSpacing.small),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.go(Routes.connectionLogs),
              icon: const Icon(Icons.timeline),
              label: const Text('Connection Logs'),
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'View Bluetooth connection debug logs to diagnose connectivity issues',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return SettingsSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSectionHeader(
            icon: Icons.info,
            gradientColors: const [
              Color(0xFF22C55E),
              Color(0xFF3B82F6),
            ],
            title: 'App Info',
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Version: 0.1.0-alpha',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Build: Alpha 1',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Open source community project to control Vitruvian Trainer machines locally.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    PreferencesActions actions,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await DeleteConfirmationDialog.show(context);
    if (confirmed == true && mounted) {
      try {
        await actions.deleteAllWorkouts();
        if (mounted) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text('All workouts deleted successfully'),
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          messenger.showSnackBar(
            SnackBar(
              content: Text('Failed to delete workouts: $error'),
            ),
          );
        }
      }
    }
  }
}
