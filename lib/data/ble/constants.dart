import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// BLE (Bluetooth Low Energy) Constants for Vitruvian Device Communication
/// 
/// Contains all UUIDs for GATT services and characteristics used to communicate
/// with Vitruvian resistance training machines via Nordic UART Service (NUS).
class BleConstants {
  BleConstants._(); // Private constructor to prevent instantiation

  // Service UUIDs
  
  /// Generic Attribute Profile (GATT) service - standard BLE service
  static final Guid gattServiceUuid = Guid("00001801-0000-1000-8000-00805f9b34fb");
  
  /// Nordic UART Service (NUS) - custom service for serial communication over BLE
  static final Guid nusServiceUuid = Guid("6e400001-b5a3-f393-e0a9-e50e24dcca9e");

  // Characteristic UUIDs
  
  /// NUS RX characteristic - write commands to device
  static final Guid nusRxCharUuid = Guid("6e400002-b5a3-f393-e0a9-e50e24dcca9e");
  
  /// Monitor characteristic - polled at 100ms intervals for real-time workout data
  /// (position, velocity, force, power, etc.)
  static final Guid monitorCharUuid = Guid("90e991a6-c548-44ed-969b-eb541014eae3");
  
  /// Property characteristic - device properties and configuration
  static final Guid propertyCharUuid = Guid("5fa538ec-d041-42f6-bbd6-c30d475387b7");
  
  /// Rep notify characteristic - sends notification when rep is completed
  static final Guid repNotifyCharUuid = Guid("8308f2a6-0875-4a94-a86f-5c5c5e1b068a");

  /// Notification characteristics - various event notifications from device
  static final List<Guid> notifyCharUuids = [
    Guid("383f7276-49af-4335-9072-f01b0f8acad6"),
    Guid("74e994ac-0e80-4c02-9cd0-76cb31d3959b"),
    Guid("67d0dae0-5bfc-4ea2-acc9-ac784dee7f29"),
    repNotifyCharUuid,
    Guid("c7b73007-b245-4503-a1ed-9e4e97eb9802"),
    Guid("36e6c2ee-21c7-404e-aa9b-f74ca4728ad4"),
    Guid("ef0e485a-8749-4314-b1be-01e57cd1712e"),
  ];

  /// Workout command characteristics - used to send workout control commands
  static final List<Guid> workoutCmdCharUuids = [
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6a5"),
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6a6"),
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6a7"),
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6a8"),
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6a9"),
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6aa"),
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6ab"),
    Guid("6d094aa3-b60d-4916-8a55-8ed73fb9f6ac"),
  ];

  // Device identification and timeouts
  
  /// Device name prefix for Vitruvian devices during BLE scanning
  static const String deviceNamePrefix = "Vee";
  
  /// Maximum time to wait for BLE connection establishment (15 seconds)
  static const int connectionTimeoutMs = 15000;
  
  /// Maximum time to wait for GATT operations (read/write/subscribe) (5 seconds)
  static const int gattOperationTimeoutMs = 5000;
  
  /// Maximum time to scan for BLE devices (30 seconds)
  static const int scanTimeoutMs = 30000;
}

/// Workout-related Constants
/// 
/// Physical limits, conversion factors, and default values for workout tracking.
class WorkoutConstants {
  WorkoutConstants._(); // Private constructor to prevent instantiation

  /// Conversion factor: pounds per kilogram
  static const double lbPerKg = 2.2046226218488;
  
  /// Conversion factor: kilograms per pound
  static const double kgPerLb = 1 / lbPerKg;
  
  /// Minimum weight in kilograms (device limit)
  static const double minWeightKg = 0.0;
  
  /// Maximum weight in kilograms (device limit)
  static const double maxWeightKg = 100.0;
  
  /// Maximum progression weight in kilograms (for progressive overload)
  static const double maxProgressionKg = 3.0;
  
  /// Default number of repetitions for warmup sets
  static const int defaultWarmupReps = 3;
  
  /// Maximum number of data points to store in workout history (20 hours @ 100Hz)
  static const int maxHistoryPoints = 72000;
  
  /// Maximum position value from device encoder (fully extended)
  static const int maxPosition = 3000;
  
  /// Minimum position value from device encoder (fully retracted)
  static const int minPosition = 0;
}

/// Protocol Constants for BLE Communication
/// 
/// Binary protocol frame definitions for communicating with Vitruvian device.
/// CRITICAL: These values CANNOT be changed - they define the hardware protocol.
class ProtocolConstants {
  ProtocolConstants._(); // Private constructor to prevent instantiation

  // Command identifiers (first byte of frame)
  
  /// Initialize device command
  static const int cmdInit = 0x0A;
  
  /// Initialize with preset parameters command
  static const int cmdInitPreset = 0x11;
  
  /// Set program parameters command
  static const int cmdProgramParams = 0x04;
  
  /// Echo control command (for Echo mode workout)
  static const int cmdEchoControl = 0x13;
  
  /// Set color scheme command (LED control)
  static const int cmdColorScheme = 0x1D;

  // Frame sizes (in bytes)
  
  /// Size of init command frame
  static const int initCmdSize = 4;
  
  /// Size of init preset command frame
  static const int initPresetSize = 34;
  
  /// Size of program parameters frame
  static const int programParamsSize = 96;
  
  /// Size of echo control frame
  static const int echoControlSize = 40;
  
  /// Size of color scheme frame
  static const int colorSchemeSize = 44;

  // Workout mode identifiers
  
  /// Old School mode - traditional resistance training
  static const int modeOldSchool = 0;
  
  /// Pump mode - constant tension, metabolic stress focus
  static const int modePump = 2;
  
  /// Time Under Tension (TUT) mode - controlled tempo
  static const int modeTut = 3;
  
  /// TUT Beast mode - advanced TUT with variable resistance
  static const int modeTutBeast = 4;
  
  /// Eccentric Only mode - resistance only on lowering phase
  static const int modeEccentricOnly = 6;
  
  /// Echo mode - follow a pre-recorded workout pattern
  static const int modeEcho = 10;
}
