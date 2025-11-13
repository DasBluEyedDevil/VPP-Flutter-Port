# VPP Flutter Port

**Vitruvian Project Phoenix** - Native multi-platform Flutter port of the VitruvianRedux Android app

[![Flutter](https://img.shields.io/badge/Flutter-3.9%2B-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.9%2B-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/license-Private-red.svg)]()
[![Status](https://img.shields.io/badge/status-MVP%20Complete-green.svg)]()

## 📱 Overview

VPP Flutter Port is a sophisticated BLE-enabled fitness tracking application for controlling and monitoring Vitruvian resistance training machines. This is a complete port of the VitruvianRedux Kotlin Android app to Flutter/Dart, enabling native support across Android, iOS, Windows, macOS, and Linux platforms.

### 🎯 Purpose

The app provides comprehensive workout tracking and device control for Vitruvian Trainer users:

- **Real-time BLE Connectivity**: Connect to Vitruvian devices via Bluetooth Low Energy with 100Hz polling for real-time metrics
- **Smart Workout Tracking**: Monitor reps, sets, and resistance with automatic rep counting and form analysis
- **Just Lift Mode**: Auto-start/auto-stop workouts based on intelligent handle detection
- **Routine Management**: Create, edit, and execute custom workout routines with multiple exercises
- **Weekly Programs**: Schedule routines across a 7-day program for structured training
- **Analytics & Progress**: Track personal records, view workout history, and analyze performance trends
- **Multi-Platform**: Native performance on Android, iOS, and desktop platforms (Windows, macOS, Linux)

## ✨ Key Features

### 🔌 BLE Connectivity
- Device scanning and pairing
- Reliable connection management with auto-reconnect
- 100Hz data polling for real-time metrics
- Connection diagnostics and logging
- Graceful handling of connection loss

### 🏋️ Workout Execution
- **Active Workout Mode**: Multi-exercise routines with set/rep tracking
- **Just Lift Mode**: Freestyle workouts with auto-start/auto-stop
- **Workout Setup**: Pre-configure parameters before starting
- **Real-time Metrics**: Live rep counting, resistance tracking, and form feedback
- **Rest Timers**: Configurable rest periods between sets
- **Set Summaries**: Detailed performance metrics for each completed set

### 📋 Routine Management
- Create custom workout routines
- Searchable exercise library
- Drag-and-drop exercise reordering
- Configure exercise parameters (sets, reps, resistance, tempo)
- Edit and delete exercises
- Duplicate routines for variations

### 📅 Program Scheduling
- Weekly program builder (7-day scheduling)
- Assign routines to specific days
- Active program tracking
- "Today's workout" detection and quick access

### 📊 Analytics & History
- Comprehensive workout history with filtering
- Personal record (PR) tracking and celebration
- Performance trends and progression charts
- Exercise-specific analytics
- Historical data visualization with fl_chart

### ⚙️ Settings & Customization
- Weight unit preferences (kg/lb)
- Theme toggle (light/dark mode)
- Workout configuration (rest times, auto-start settings)
- LED color scheme customization
- Data management and export

## 🛠️ Technology Stack

### Core Technologies
- **Flutter 3.9+**: Cross-platform UI framework
- **Dart 3.9+**: Modern, null-safe programming language
- **Material 3**: Latest Material Design guidelines

### State Management & Architecture
- **Riverpod**: State management and dependency injection (replaces Hilt + ViewModels)
- **Clean Architecture**: Separation of concerns with domain/data/presentation layers
- **StateNotifier**: Predictable state management pattern
- **StreamProvider**: Reactive BLE data streams

### Data & Persistence
- **Drift**: Type-safe SQL database (replaces Room ORM)
- **SharedPreferences**: User preferences storage
- **JSON Serialization**: Data serialization with json_annotation

### BLE & Device Communication
- **flutter_blue_plus**: Bluetooth Low Energy communication (replaces Nordic BLE Library)
- **100Hz Polling**: High-frequency data updates for real-time feedback
- **Custom Protocol**: Binary protocol matching Kotlin implementation

### UI & Visualization
- **fl_chart**: Beautiful, performant charts and graphs (replaces MPAndroidChart)
- **go_router**: Type-safe navigation
- **Confetti**: Celebration animations for PRs
- **Material 3 Widgets**: Modern, accessible UI components

### Development Tools
- **freezed**: Immutable data classes
- **riverpod_generator**: Code generation for providers
- **build_runner**: Code generation automation
- **mockito**: Testing framework

## 🎨 Architecture

The app follows **Clean Architecture** principles with three distinct layers:

```
lib/
├── domain/          # Business logic & models
│   ├── models/      # Immutable domain entities (freezed)
│   └── repositories/# Repository interfaces
├── data/            # Data sources & implementations
│   ├── database/    # Drift database (SQLite)
│   ├── ble/         # BLE protocol & communication
│   └── repositories/# Repository implementations
└── presentation/    # UI & state management
    ├── providers/   # Riverpod providers (StateNotifier)
    ├── screens/     # Full-screen views (15 screens)
    └── widgets/     # Reusable components
```

### Key Architectural Patterns
- **Repository Pattern**: Abstraction of data sources
- **Dependency Injection**: Riverpod providers for loose coupling
- **Single Source of Truth**: StateNotifier manages all state
- **Unidirectional Data Flow**: Events flow up, state flows down
- **Separation of Concerns**: Clear boundaries between layers

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9 or higher
- Dart SDK 3.9 or higher
- Android Studio / VS Code with Flutter extensions
- For iOS: Xcode (macOS only)
- For desktop: Platform-specific build tools

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/DasBluEyedDevil/VPP-Flutter-Port.git
   cd VPP-Flutter-Port
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for Drift, Riverpod, Freezed)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Verify setup**
   ```bash
   flutter doctor
   ```

### Running the App

**On Android/iOS Device or Emulator:**
```bash
flutter run
```

**On Desktop (Windows/macOS/Linux):**
```bash
flutter run -d windows  # Windows
flutter run -d macos    # macOS
flutter run -d linux    # Linux
```

**Select specific device:**
```bash
flutter devices        # List available devices
flutter run -d <device-id>
```

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/domain/models/workout_test.dart
```

### Code Coverage
```bash
flutter test --coverage
```

### Analyze Code Quality
```bash
flutter analyze
```

### Format Code
```bash
dart format .
```

## 🔨 Building

### Android APK (Debug)
```bash
flutter build apk --debug
```

### Android APK (Release)
```bash
flutter build apk --release
```

### iOS (macOS only)
```bash
flutter build ios --release
```

### Desktop Builds
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android  | ✅ Primary | Full BLE support, tested on Android 8+ |
| iOS      | ✅ Supported | BLE requires iOS 12+, Core Bluetooth |
| Windows  | ✅ Supported | BLE requires Windows 10+ with Bluetooth 4.0 |
| macOS    | ✅ Supported | BLE requires macOS 10.15+ |
| Linux    | ✅ Supported | BLE requires BlueZ stack |

## 📂 Project Structure

### Screens (15 total)
1. **Splash Screen** - App initialization
2. **Home Screen** - Dashboard with quick actions
3. **Main Screen** - Navigation wrapper with bottom tabs
4. **Workout Tab** - Today's workout and quick start
5. **Active Workout** - Real-time workout execution
6. **Just Lift Screen** - Freestyle workout mode
7. **Connection Logs** - BLE diagnostics
8. **Daily Routines** - Routine management
9. **Routines Tab** - Browse and edit routines
10. **Weekly Programs** - 7-day program scheduling
11. **Program Builder** - Create/edit programs
12. **History Tab** - Workout history browser
13. **Settings Tab** - App configuration
14. **Analytics Screen** - Performance analytics (3 tabs)
15. **Single Exercise** - Single-exercise workout mode

### Key Components
- **RoutineBuilderDialog**: Create/edit routines
- **ExercisePickerDialog**: Searchable exercise selection
- **ExerciseEditBottomSheet**: Exercise parameter configuration
- **WorkoutSetupDialog**: Pre-workout configuration
- **ExerciseListItem**: Drag-and-drop exercise list items
- **TrendsTab**: PR progression charts
- **ExerciseProgressionCard**: Exercise-specific analytics

## 🔐 Permissions

### Android
```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

### iOS
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app requires Bluetooth to connect to Vitruvian devices</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app requires Bluetooth to communicate with Vitruvian devices</string>
```

## ⚠️ Important Notes

1. **BLE Protocol Compatibility**: All BLE frames must EXACTLY match the Kotlin implementation. Protocol bytes cannot be modified.

2. **Hardware Required**: Full functionality requires a physical Vitruvian Trainer device. BLE features cannot be fully tested without hardware.

3. **Active Polling**: The device does NOT send notifications for metrics. The app MUST actively poll every 100ms.

4. **Connection Management**: Proper handling of BLE connection lifecycle is critical. Includes timeout mechanisms and graceful degradation.

5. **Cross-Platform Quirks**: BLE behavior differs slightly across platforms. Extensive testing recommended on target platforms.

## 🎯 Current Status

**Version**: 0.1.0-alpha  
**Status**: MVP Complete (100% feature-complete)  
**Screens**: 15/15 implemented  
**Build**: ✅ All files compile successfully  
**Analysis**: ✅ 0 errors from `flutter analyze`  

### Ready For:
- ✅ Build and run on physical devices
- ✅ BLE hardware testing with Vitruvian Trainer
- ✅ End-to-end workflow testing
- ✅ Performance optimization
- ✅ User acceptance testing

### Next Steps:
1. Physical device testing with Vitruvian hardware
2. Integration testing of complete workflows
3. Performance profiling (100Hz BLE polling)
4. Bug fixes based on testing feedback
5. UI/UX polish and refinements
6. Production deployment preparation

## 🤝 Contributing

This is a private project. For development guidelines:

1. Follow Clean Architecture principles
2. Use Riverpod for state management
3. Maintain null safety
4. Write tests for new features
5. Run `flutter analyze` before committing
6. Follow conventional commit messages
7. Update documentation for significant changes

## 📝 License

Private - All rights reserved

## 🙏 Acknowledgments

- **Original App**: VitruvianRedux (Kotlin Android implementation)
- **Vitruvian**: For the innovative resistance training hardware
- **Flutter Team**: For the excellent cross-platform framework
- **Community**: flutter_blue_plus, Drift, Riverpod, and other package maintainers

## 📞 Support

For issues, questions, or feature requests related to the Vitruvian hardware, please contact Vitruvian support.

For app-specific technical issues, please refer to the project documentation in the `docs/` directory.

---

**Built with ❤️ using Flutter**
