/// Vitruvian Hardware Model Detection
///
/// Identifies which generation of Vitruvian Trainer is connected based on device name
/// and determines hardware capabilities.
///
/// Known Models:
/// - Euclid (VIT-200): Original V-Form Trainer with older motors
///   - Device names start with "Vee"
///   - Limited eccentric mode support due to hardware constraints
///
/// - Trainer+: Second generation with improved motors
///   - Better eccentric mode performance
///   - Smoother operation overall
///
/// Note: Currently we can only detect Euclid devices via "Vee" prefix.
/// Trainer+ detection would require additional device name patterns to be identified.
class HardwareDetection {
  HardwareDetection._(); // Private constructor - static class

  /// Detect Vitruvian hardware model from device name
  static VitruvianModel detectModel(String deviceName) {
    // Euclid/V-Form devices use "Vee" prefix
    if (deviceName.toLowerCase().startsWith('vee')) {
      return VitruvianModel.euclid;
    }

    // Trainer+ detection pattern (to be confirmed with actual device names)
    if (deviceName.toLowerCase().startsWith('vitruvian')) {
      return VitruvianModel.trainerPlus;
    }

    // Default to unknown if pattern doesn't match
    return VitruvianModel.unknown;
  }

  /// Get hardware capabilities for a device name
  static HardwareCapabilities getCapabilities(String deviceName) {
    final model = detectModel(deviceName);
    return model.capabilities;
  }

  /// Check if eccentric mode is supported on this device
  static bool supportsEccentricMode(String deviceName) {
    return getCapabilities(deviceName).supportsEccentricMode;
  }

  /// Get user-friendly model name for display
  static String getDisplayName(String deviceName) {
    final model = detectModel(deviceName);
    return '${model.displayName} ($deviceName)';
  }
}

/// Vitruvian hardware models
enum VitruvianModel {
  /// Euclid (VIT-200) - Original V-Form Trainer
  /// First generation with eccentric mode support (confirmed in 2021 reviews)
  /// However, users report eccentric-only mode not working properly on this hardware
  euclid(
    modelNumber: 'VIT-200',
    displayName: 'Vitruvian V-Form Trainer (Euclid)',
    capabilities: HardwareCapabilities(
      supportsEccentricMode: true, // Feature exists but has known issues
      supportsEchoMode: true,
      maxResistanceKg: 200.0,
      notes:
          'Original V-Form Trainer. Eccentric-only mode supported but may not work correctly - under investigation.',
    ),
  ),

  /// Trainer+ - Second generation with improved motors
  trainerPlus(
    modelNumber: 'VIT-300', // Assumed model number
    displayName: 'Vitruvian Trainer+',
    capabilities: HardwareCapabilities(
      supportsEccentricMode: true,
      supportsEchoMode: true,
      maxResistanceKg: 220.0,
      notes:
          'Second generation with improved motors for better eccentric mode performance.',
    ),
  ),

  /// Unknown model - treat conservatively
  unknown(
    modelNumber: 'UNKNOWN',
    displayName: 'Unknown Vitruvian Model',
    capabilities: HardwareCapabilities(
      supportsEccentricMode: true, // Assume support for unknown devices
      supportsEchoMode: true,
      maxResistanceKg: 200.0,
      notes: 'Unknown device model. Capabilities assumed.',
    ),
  );

  const VitruvianModel({
    required this.modelNumber,
    required this.displayName,
    required this.capabilities,
  });

  final String modelNumber;
  final String displayName;
  final HardwareCapabilities capabilities;
}

/// Hardware capabilities for a specific Vitruvian model
class HardwareCapabilities {
  const HardwareCapabilities({
    required this.supportsEccentricMode,
    required this.supportsEchoMode,
    required this.maxResistanceKg,
    this.notes = '',
  });

  final bool supportsEccentricMode;
  final bool supportsEchoMode;
  final double maxResistanceKg;
  final String notes;

  @override
  String toString() {
    return 'HardwareCapabilities(supportsEccentricMode: $supportsEccentricMode, '
        'supportsEchoMode: $supportsEchoMode, maxResistanceKg: $maxResistanceKg, '
        'notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HardwareCapabilities &&
        other.supportsEccentricMode == supportsEccentricMode &&
        other.supportsEchoMode == supportsEchoMode &&
        other.maxResistanceKg == maxResistanceKg &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return supportsEccentricMode.hashCode ^
        supportsEchoMode.hashCode ^
        maxResistanceKg.hashCode ^
        notes.hashCode;
  }
}
