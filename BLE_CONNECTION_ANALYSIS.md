# BLE Connection Screen - Extreme Detail Analysis
**Vitruvian Redux (Kotlin) → Flutter Port Specification**

---

## 1. SCREEN IDENTIFICATION

### Primary Implementation
The BLE connection UI in VitruvianRedux is **NOT a dedicated screen**. Instead, it's integrated into multiple components:

1. **EnhancedMainScreen.kt** (lines 38-389)
   - TopAppBar connection status icon with click-to-connect
   - Device selection dialog (`DeviceSelectorDialog`, lines 439-531)
   - Permission request screen (lines 391-436)

2. **HomeScreen.kt** (lines 38-398)
   - Auto-connect overlays for workout start flows

3. **Connection Components** (separate files):
   - `ConnectingOverlay.kt` - Full-screen connection animation
   - `ConnectionStatusBanner.kt` - Warning banner for disconnected state
   - `ConnectionErrorDialog.kt` - Error handling with troubleshooting
   - `ConnectionLostDialog.kt` - Workout interruption alert

### ViewModel
**MainViewModel.kt** manages all BLE connection state:
- Lines 42-50: BLE repository injection and context
- Line 55: `connectionState: StateFlow<ConnectionState>`
- Lines 88-89: `scannedDevices: StateFlow<List<ScannedDevice>>`
- Lines 236-240: Auto-connect UI state
- Lines 542-688: Connection management methods

### Data Model
```kotlin
// Line 1744-1748 in MainViewModel.kt
data class ScannedDevice(
    val name: String,
    val address: String,
    val rssi: Int = 0  // Signal strength in dBm
)
```

---

## 2. COMPLETE LAYOUT HIERARCHY

### 2.1 TopAppBar Connection Indicator (EnhancedMainScreen)

```
TopAppBar
└── actions
    └── Column (Connection Status - lines 110-172)
        ├── modifier: padding(horizontal=4.dp)
        ├── minSize: 48dp × 48dp (touch target)
        ├── clickable: toggle connect/disconnect
        │
        ├── Icon (Bluetooth status - lines 130-153)
        │   ├── size: 20dp
        │   └── Dynamic based on ConnectionState
        │
        └── Text (Status label - lines 154-171)
            ├── style: labelSmall
            ├── fontSize: 9sp
            └── maxLines: 1
```

### 2.2 Device Selector Dialog (DeviceSelectorDialog)

```
AlertDialog (lines 446-531)
├── onDismissRequest: onDismiss
│
├── title
│   └── Text: "Select Vitruvian Device"
│
├── text
│   └── Column (fillMaxWidth)
│       │
│       ├── [Empty State] (lines 451-471)
│       │   └── Column (padding=16dp)
│       │       ├── if scanning:
│       │       │   └── Row
│       │       │       ├── CircularProgressIndicator (size=18dp)
│       │       │       ├── Spacer (width=8dp)
│       │       │       └── Text: "Scanning..."
│       │       └── else:
│       │           └── Text: "No devices found. Try scanning again."
│       │
│       └── [Device List] (lines 474-513)
│           └── LazyColumn (spacing=4dp)
│               └── items(devices, key=address)
│                   └── Card (lines 477-510)
│                       ├── fillMaxWidth
│                       ├── clickable: onDeviceSelected
│                       ├── containerColor: surfaceVariant
│                       ├── shape: RoundedCornerShape(16.dp)
│                       │
│                       └── Row (padding=16dp)
│                           ├── Column (weight=1f)
│                           │   ├── Text (device.name)
│                           │   │   ├── style: bodyLarge
│                           │   │   ├── fontWeight: Bold
│                           │   │   └── color: onSurface
│                           │   └── Text (device.address)
│                           │       ├── style: bodySmall
│                           │       └── color: onSurfaceVariant
│                           │
│                           └── Icon (ArrowRight)
│                               ├── imageVector: KeyboardArrowRight
│                               └── tint: primary
│
├── confirmButton (lines 516-524)
│   └── if !isScanning:
│       └── TextButton (onClick: onRescan)
│           ├── Icon: Refresh (size=18dp, tint=primary)
│           ├── Spacer (width=4dp)
│           └── Text: "Rescan" (color=primary)
│
└── dismissButton (lines 525-529)
    └── TextButton (onClick: onDismiss)
        └── Text: "Cancel" (color=onSurfaceVariant)
```

### 2.3 Connecting Overlay (ConnectingOverlay.kt)

```
Dialog (lines 25-71)
├── properties:
│   ├── dismissOnBackPress: false
│   ├── dismissOnClickOutside: false
│   └── usePlatformDefaultWidth: false (full screen)
│
└── Box (fillMaxSize)
    ├── background: scrim @ 60% opacity
    ├── contentAlignment: Center
    │
    └── Card (padding=32dp)
        └── Column (padding=32dp, spacing=16dp)
            ├── CircularProgressIndicator (size=48dp)
            ├── Text: "Connecting to device..."
            │   └── style: titleMedium
            ├── Text: "Scanning for Vitruvian Trainer"
            │   ├── style: bodySmall
            │   └── color: onSurfaceVariant
            └── TextButton (onClick: onCancel, padding-top=8dp)
                └── Text: "Cancel"
```

### 2.4 Connection Status Banner (ConnectionStatusBanner.kt)

```
Card (lines 28-77)
├── fillMaxWidth
├── padding: horizontal=16dp, vertical=8dp
├── containerColor: surfaceContainerHighest
├── shape: medium
│
└── Row (fillMaxWidth, padding=16dp)
    ├── Row (weight=1f, spacing=8dp) - Status
    │   ├── Icon (Bluetooth)
    │   │   ├── tint: error
    │   │   └── size: 24dp
    │   └── Text: "Not connected to machine"
    │       ├── style: bodyMedium
    │       ├── color: onSurface
    │       └── fontWeight: Medium
    │
    └── TextButton (onClick: onConnect, padding-start=16dp)
        └── Text: "Connect"
            ├── style: labelLarge
            └── fontWeight: Bold
```

### 2.5 Connection Error Dialog (ConnectionErrorDialog.kt)

```
AlertDialog (lines 22-69)
├── icon: Warning icon
├── title: "Connection Failed"
│
├── text
│   └── Column (fillMaxWidth, spacing=12dp)
│       ├── Text (error message)
│       │   └── style: bodyMedium
│       ├── Divider (padding-vertical=4dp)
│       ├── Text: "Troubleshooting tips:"
│       │   ├── style: labelLarge
│       │   ├── fontWeight: Bold
│       │   └── color: primary
│       └── Column (spacing=6dp)
│           ├── "• Ensure the machine is powered on"
│           ├── "• Try turning Bluetooth off and on"
│           ├── "• Move closer to the machine"
│           └── "• Check that no other device is connected"
│
├── confirmButton: "Retry" (if onRetry provided)
└── dismissButton: "OK"
```

### 2.6 Connection Lost Dialog (ConnectionLostDialog.kt)

```
AlertDialog (lines 27-71)
├── icon: BluetoothDisabled (tint: error)
├── title: "Connection Lost" (headlineSmall, Bold)
│
├── text
│   └── Column
│       ├── Text: "Bluetooth connection to the trainer was lost during your workout."
│       │   └── style: bodyLarge
│       ├── Spacer (height=8dp)
│       └── Text: "Rep tracking may have been interrupted. Please reconnect to continue."
│           ├── style: bodyMedium
│           └── color: onSurfaceVariant
│
├── confirmButton: "Reconnect" (Bold)
└── dismissButton: "Dismiss"
```

### 2.7 Permission Request Screen (PermissionRequestScreen)

```
Column (lines 397-436)
├── fillMaxSize
├── padding: 24dp (Spacing.large)
├── horizontalAlignment: Center
├── verticalAlignment: Center
│
├── Icon (Info)
│   ├── tint: primary
│   └── size: 64dp
├── Spacer (height=16dp)
├── Text: "Bluetooth permissions required"
│   ├── style: headlineSmall
│   ├── fontWeight: Bold
│   └── color: onBackground
├── Spacer (height=8dp)
├── Text: "This app needs Bluetooth and Location permissions to connect to your Vitruvian machine."
│   ├── style: bodyMedium
│   ├── color: onSurfaceVariant
│   └── textAlign: Center
├── Spacer (height=24dp)
└── Button (onClick: launchPermissionRequest)
    ├── Icon: Check
    ├── Spacer (width=8dp)
    └── Text: "Grant permissions"
```

---

## 3. EVERY UI ELEMENT (Exact Properties)

### 3.1 Connection Status Icon (TopAppBar)

**Location**: EnhancedMainScreen.kt, lines 110-172

**Container Column**:
- `horizontalAlignment`: `Alignment.CenterHorizontally`
- `verticalArrangement`: `Arrangement.Center`
- `padding`: `horizontal=4.dp`
- `defaultMinSize`: `minWidth=48.dp, minHeight=48.dp` (accessibility)
- `clickable`: Toggle connect/disconnect
- `role`: `Button`

**Icon**:
- `size`: `20.dp`
- `imageVector`: Dynamic based on `ConnectionState`:
  - `Connected` → `Icons.Default.Bluetooth`
  - `Connecting` → `Icons.Default.BluetoothSearching`
  - `Disconnected` → `Icons.Default.BluetoothDisabled`
  - `Scanning` → `Icons.Default.BluetoothSearching`
  - `Error` → `Icons.Default.BluetoothDisabled`
- `tint`: Dynamic colors (see section 4)
- `contentDescription`: Dynamic status text

**Status Text**:
- `text`: "Connected" | "Connecting" | "Disconnected" | "Scanning" | "Error"
- `style`: `MaterialTheme.typography.labelSmall`
- `fontSize`: `9.sp` (override)
- `color`: Matches icon tint
- `maxLines`: `1`

### 3.2 Device List Items (DeviceSelectorDialog)

**Card Container**:
- `modifier`: `fillMaxWidth().clickable { onDeviceSelected(device) }`
- `containerColor`: `MaterialTheme.colorScheme.surfaceVariant`
- `shape`: `RoundedCornerShape(16.dp)`

**Row Layout**:
- `fillMaxWidth`
- `padding`: `16.dp` (Spacing.medium)
- `horizontalArrangement`: `SpaceBetween`
- `verticalAlignment`: `CenterVertically`

**Device Name Text**:
- `text`: `device.name` (e.g., "Vitruvian Trainer")
- `style`: `MaterialTheme.typography.bodyLarge`
- `fontWeight`: `FontWeight.Bold`
- `color`: `MaterialTheme.colorScheme.onSurface`

**MAC Address Text**:
- `text`: `device.address` (e.g., "00:1A:7D:DA:71:13")
- `style`: `MaterialTheme.typography.bodySmall`
- `color`: `MaterialTheme.colorScheme.onSurfaceVariant`

**Arrow Icon**:
- `imageVector`: `Icons.AutoMirrored.Filled.KeyboardArrowRight`
- `tint`: `MaterialTheme.colorScheme.primary`
- `contentDescription`: `null` (decorative)

**NOTE**: RSSI signal strength is captured in data model but **NOT displayed** in UI

### 3.3 Scan/Rescan Button (DeviceSelectorDialog)

**TextButton**:
- `onClick`: `onRescan`
- Only visible when `!isScanning`

**Icon**:
- `imageVector`: `Icons.Default.Refresh`
- `size`: `18.dp`
- `tint`: `MaterialTheme.colorScheme.primary`

**Spacer**: `width=4.dp` (Spacing.extraSmall)

**Text**:
- `text`: "Rescan"
- `color`: `MaterialTheme.colorScheme.primary`

### 3.4 Scanning Indicator

**CircularProgressIndicator**:
- `size`: `18.dp` (in dialog) or `48.dp` (in overlay)
- Default Material 3 styling

**Text**: "Scanning..."
- No specific style overrides (defaults to dialog text style)

### 3.5 Empty State (No Devices Found)

**Text**: "No devices found. Try scanning again."
- `color`: `MaterialTheme.colorScheme.onSurfaceVariant`
- `textAlign`: `TextAlign.Center`

### 3.6 Connection Banner Elements

**Bluetooth Icon**:
- `imageVector`: `Icons.Default.Bluetooth`
- `tint`: `MaterialTheme.colorScheme.error`
- `size`: `24.dp`
- `contentDescription`: `null` (message provides context)

**Message Text**: "Not connected to machine"
- `style`: `MaterialTheme.typography.bodyMedium`
- `color`: `MaterialTheme.colorScheme.onSurface`
- `fontWeight`: `FontWeight.Medium`

**Connect Button**:
- `style`: `TextButton`
- Text: "Connect"
- `labelLarge` style
- `fontWeight`: `FontWeight.Bold`

---

## 4. ALL COLORS (With Hex Codes)

### 4.1 Connection Status Icon Colors

**Source**: EnhancedMainScreen.kt, lines 145-169

| State | Icon Color | Hex Code | Description |
|-------|-----------|----------|-------------|
| Connected | Green | `#22C55E` | green-500 (Tailwind) |
| Connecting | Yellow | `#FBBF24` | yellow-400 |
| Disconnected | Red | `#EF4444` | red-500 |
| Scanning | Blue | `#3B82F6` | blue-500 |
| Error | Red | `#EF4444` | red-500 |

### 4.2 Theme Colors

**Source**: Color.kt and Theme.kt

#### Dark Theme Colors
```kotlin
// Background Colors
BackgroundBlack = #000000        // Pure black background
BackgroundDarkGrey = #121212     // Dark grey surface
SurfaceDarkGrey = #1E1E1E        // Elevated surfaces
CardBackground = #252525         // Card backgrounds

// Purple Accent Colors
PrimaryPurple = #BB86FC         // Primary purple (Material 3)
SecondaryPurple = #9965F4       // Deeper purple
TertiaryPurple = #E0BBF7        // Light purple highlights
PurpleAccent = #7E57C2          // Accent purple for buttons

// TopAppBar Colors
TopAppBarDark = #1A0E26         // Very dark purple (dark mode header)
TopAppBarLight = #4A2F8A        // Darker purple (light mode header)

// Text Colors
TextPrimary = #FFFFFF           // Pure white text
TextSecondary = #E0E0E0         // Light grey text
TextTertiary = #B0B0B0          // Medium grey text
TextDisabled = #707070          // Disabled text

// Status Colors
SuccessGreen = #4CAF50          // Success states
ErrorRed = #F44336              // Error states
WarningOrange = #FF9800         // Warning states
InfoBlue = #2196F3              // Info states
```

#### Light Theme Colors
```kotlin
ColorLightBackground = #F8F9FB     // Soft light background
ColorOnLightBackground = #0F172A   // Slate-900 like text
ColorLightSurface = #FFFFFF        // White surface
ColorOnLightSurface = #111827      // Dark text on surface
ColorLightSurfaceVariant = #F3F4F6 // Light gray surface variant
ColorOnLightSurfaceVariant = #6B7280 // Gray-500 text
```

### 4.3 Device Selector Dialog Colors

| Element | Property | Value |
|---------|----------|-------|
| Card Container | `containerColor` | `MaterialTheme.colorScheme.surfaceVariant` |
| Device Name | `color` | `MaterialTheme.colorScheme.onSurface` |
| MAC Address | `color` | `MaterialTheme.colorScheme.onSurfaceVariant` |
| Arrow Icon | `tint` | `MaterialTheme.colorScheme.primary` |
| Rescan Button | `color` | `MaterialTheme.colorScheme.primary` |
| Cancel Button | `color` | `MaterialTheme.colorScheme.onSurfaceVariant` |

### 4.4 Connecting Overlay Colors

| Element | Property | Value |
|---------|----------|-------|
| Background Scrim | `background` | `MaterialTheme.colorScheme.scrim @ 60% alpha` |
| Card | Default Material 3 card colors | |

### 4.5 Error/Warning Colors

| Component | Element | Color | Hex |
|-----------|---------|-------|-----|
| Connection Banner | Bluetooth Icon | `error` | `#F44336` (dark) |
| Connection Error Dialog | Warning Icon | Default yellow | Material 3 |
| Connection Lost Dialog | Bluetooth Disabled Icon | `error` | `#F44336` (dark) |

### 4.6 Specific UI Element Colors

**Card Border** (HomeScreen WorkoutCard):
- `BorderStroke(1.dp, Color(0xFFF5F3FF))` - purple-50

**Purple Accent Gradient** (used in HomeScreen):
- `Color(0xFF9333EA)` - purple-500
- `Color(0xFF7E22CE)` - purple-700

**Active Indicator** (Bottom Navigation):
- `Color(0xFF9333EA)` - purple-500

---

## 5. ALL TYPOGRAPHY

**Source**: Type.kt (lines 1-118)

### Typography System (Material 3)

| Style | Font Family | Weight | Size (sp) | Line Height (sp) | Letter Spacing (sp) |
|-------|-------------|--------|-----------|------------------|---------------------|
| `displayLarge` | Default (Roboto) | Bold | 57 | 64 | -0.25 |
| `displayMedium` | Default | Bold | 45 | 52 | 0 |
| `headlineLarge` | Default | SemiBold | 32 | 40 | 0 |
| `headlineMedium` | Default | SemiBold | 28 | 36 | 0 |
| `headlineSmall` | Default | SemiBold | 24 | 32 | 0 |
| `titleLarge` | Default | SemiBold | 22 | 28 | 0 |
| `titleMedium` | Default | Medium | 16 | 24 | 0.15 |
| `titleSmall` | Default | Medium | 14 | 20 | 0.1 |
| `bodyLarge` | Default | Normal | 16 | 24 | 0.5 |
| `bodyMedium` | Default | Normal | 14 | 20 | 0.25 |
| `bodySmall` | Default | Normal | 12 | 16 | 0.4 |
| `labelLarge` | Default | Medium | 14 | 20 | 0.1 |
| `labelMedium` | Default | Medium | 12 | 16 | 0.5 |
| `labelSmall` | Default | Medium | 11 | 16 | 0.5 |

### Used Typography in BLE Connection UI

| Element | Style | Overrides |
|---------|-------|-----------|
| Connection Status Text (TopAppBar) | `labelSmall` | `fontSize: 9.sp` |
| Dialog Title | Material 3 default | - |
| Device Name | `bodyLarge` | `fontWeight: Bold` |
| MAC Address | `bodySmall` | - |
| Scanning Text | Default | - |
| Empty State Text | Default | - |
| Connecting Overlay Title | `titleMedium` | - |
| Connecting Overlay Subtitle | `bodySmall` | - |
| Banner Message | `bodyMedium` | `fontWeight: Medium` |
| Error Dialog Message | `bodyMedium` | - |
| Troubleshooting Header | `labelLarge` | `fontWeight: Bold` |
| Troubleshooting Items | `bodySmall` | - |
| Connection Lost Title | `headlineSmall` | `fontWeight: Bold` |
| Connection Lost Message | `bodyLarge` | - |
| Permission Request Title | `headlineSmall` | `fontWeight: Bold` |
| Permission Request Message | `bodyMedium` | - |

---

## 6. ALL SPACING VALUES

**Source**: Spacing.kt (8dp grid system)

### Spacing Constants
```kotlin
object Spacing {
    val extraSmall = 4.dp
    val small = 8.dp
    val medium = 16.dp
    val large = 24.dp
    val extraLarge = 32.dp
    val huge = 48.dp
}
```

### Applied Spacing in BLE UI

| Component | Property | Value | Constant |
|-----------|----------|-------|----------|
| TopAppBar Icon | horizontal padding | 4dp | - |
| Dialog Device List | verticalArrangement | 4dp spacing | `extraSmall` |
| Device Card | padding | 16dp | `medium` |
| Device Card Row | horizontalArrangement | 16dp spacing | `medium` |
| Rescan Button Icon | Spacer width | 4dp | `extraSmall` |
| Connecting Overlay Card | padding | 32dp | `extraLarge` |
| Connecting Overlay Column | padding | 32dp | `extraLarge` |
| Connecting Overlay Column | verticalArrangement | 16dp spacing | `medium` |
| Connecting Overlay Button | padding-top | 8dp | `small` |
| Connection Banner | horizontal padding | 16dp | `medium` |
| Connection Banner | vertical padding | 8dp | `small` |
| Connection Banner Row | padding | 16dp | `medium` |
| Connection Banner Row | horizontalArrangement | 8dp spacing | `small` |
| Connection Banner Button | padding-start | 16dp | `medium` |
| Error Dialog Column | verticalArrangement | 12dp spacing | - |
| Error Dialog Divider | padding-vertical | 4dp | `extraSmall` |
| Error Dialog Items | verticalArrangement | 6dp spacing | - |
| Connection Lost Spacer | height | 8dp | `small` |
| Permission Screen | padding | 24dp | `large` |
| Permission Icon to Title | height | 16dp | `medium` |
| Permission Title to Message | height | 8dp | `small` |
| Permission Message to Button | height | 24dp | `large` |
| Permission Button Icon to Text | width | 8dp | `small` |

### Card Corner Radius
- Device cards: `16.dp`
- Connecting overlay card icon container: `12.dp`

### Icon Sizes
- TopAppBar connection icon: `20.dp`
- Scanning indicator (dialog): `18.dp`
- Scanning indicator (overlay): `48.dp`
- Refresh icon: `18.dp`
- Banner Bluetooth icon: `24.dp`
- Permission Info icon: `64.dp`
- Touch target minimum: `48dp × 48dp`

---

## 7. ALL INTERACTIONS

### 7.1 Connection Status Icon (TopAppBar)

**Click Behavior** (lines 116-128):
```kotlin
clickable {
    if (connectionState is ConnectionState.Connected) {
        viewModel.disconnect()
    } else {
        viewModel.ensureConnection(
            onConnected = {},
            onFailed = {}
        )
    }
}
```

**States**:
- **Connected**: Click to disconnect
- **Not Connected**: Click to scan and connect
- **Connecting/Scanning**: Click has no effect during auto-connect

**Accessibility**:
- `role`: `Button`
- `contentDescription`: Dynamic based on state

### 7.2 Device List Item (DeviceSelectorDialog)

**Click Behavior** (line 480):
```kotlin
Card(modifier = Modifier.clickable { onDeviceSelected(device) })
```

**Flow**:
1. User taps device card
2. Dialog calls `onDeviceSelected(device: ScannedDevice)`
3. ViewModel calls `connectToDevice(device.address)`
4. Dialog remains open (no auto-dismiss)
5. Connection proceeds asynchronously

**Visual Feedback**:
- Card has Material 3 ripple effect (default clickable)
- No additional pressed state animation

### 7.3 Scan/Rescan Button

**Click Behavior** (line 518):
```kotlin
TextButton(onClick = onRescan)
```

**Flow**:
1. User taps "Rescan"
2. Calls `onRescan()` → `viewModel.startScanning()`
3. Clears previous scan results: `_scannedDevices.value = emptyList()`
4. Calls `bleRepository.startScanning()`
5. Updates UI to show scanning state
6. Button hides while scanning (`if (!isScanning)`)

**Enabled State**:
- Only visible when `!isScanning`
- Hidden during active scan

### 7.4 Cancel Button (Dialog)

**Click Behavior** (line 527):
```kotlin
TextButton(onClick = onDismiss)
```

**Flow**:
1. User taps "Cancel"
2. Dialog dismisses
3. Scanning continues in background (NOT stopped)

### 7.5 Connecting Overlay Cancel

**Click Behavior** (lines 62-66 in ConnectingOverlay.kt):
```kotlin
TextButton(onClick = onCancel)
```

**Flow** (MainViewModel lines 681-688):
1. User taps "Cancel"
2. Calls `viewModel.cancelAutoConnecting()`
3. Cancels connection coroutine: `connectionJob?.cancel()`
4. Triggers `CancellationException` handler (lines 657-666)
5. Stops scanning: `stopScanning()`
6. Cancels BLE connection: `bleRepository.cancelConnection()`
7. Clears UI state: `_isAutoConnecting.value = false`
8. Clears pending callback: `_pendingConnectionCallback = null`
9. **Does NOT show error** (user intentionally cancelled)

### 7.6 Connection Banner "Connect" Button

**Click Behavior** (line 66 in ConnectionStatusBanner.kt):
```kotlin
TextButton(onClick = onConnect)
```

**Flow**:
- Typically calls `viewModel.ensureConnection()`
- Same flow as TopAppBar icon click

### 7.7 Connection Error Dialog

**Retry Button** (lines 54-61 in ConnectionErrorDialog.kt):
```kotlin
if (onRetry != null) {
    TextButton(onClick = {
        onDismiss()
        onRetry()
    })
}
```

**OK/Dismiss Button**:
```kotlin
TextButton(onClick = onDismiss)
```

**Flow**:
1. If "Retry" provided and clicked:
   - Dismiss dialog
   - Retry connection attempt
2. If "OK" clicked:
   - Dismiss dialog
   - Clear error: `viewModel.clearConnectionError()`

### 7.8 Connection Lost Dialog

**Reconnect Button** (line 58 in ConnectionLostDialog.kt):
```kotlin
TextButton(onClick = onReconnect)
```

**Flow** (EnhancedMainScreen lines 377-383):
1. User taps "Reconnect"
2. Calls `viewModel.dismissConnectionLostAlert()`
3. Calls `viewModel.ensureConnection(onConnected = {}, onFailed = {})`
4. Auto-connect flow begins

**Dismiss Button**:
1. Calls `viewModel.dismissConnectionLostAlert()`
2. Sets `_connectionLostDuringWorkout.value = false`
3. Dialog closes

### 7.9 Pull-to-Refresh

**NOT IMPLEMENTED** - No pull-to-refresh gesture in device list

### 7.10 Swipe Actions

**NOT IMPLEMENTED** - No swipe gestures on device items

### 7.11 Long-Press Actions

**NOT IMPLEMENTED** - No long-press menu

---

## 8. ANIMATIONS & TRANSITIONS

### 8.1 Scanning Animation

**CircularProgressIndicator**:
- Default Material 3 indeterminate progress indicator
- Continuous rotation animation
- Used in:
  - Device selector dialog (size: 18dp)
  - Connecting overlay (size: 48dp)

**No custom animations** for scanning state

### 8.2 Connection Progress

**Visual Indicator**:
- Same `CircularProgressIndicator` as scanning
- No distinct "connecting" vs "scanning" animation
- Progress is **indeterminate** (no percentage shown)

### 8.3 List Item Animations

**Device List**:
- Uses `LazyColumn` with `items(devices, key = { it.address })`
- **No explicit item animations** defined
- Default Compose list animations (add/remove)

### 8.4 State Transition Animations

**Connection Status Icon**:
- Icon and color change **instantly** (no animation)
- No fade or morph transition between icons
- No pulsing or breathing effect on Scanning/Connecting states

**Dialog Appearance**:
- Standard Material 3 `AlertDialog` animation
- Fade in + scale up from center
- Default 300ms duration (Material spec)

**Overlay Appearance**:
- `Dialog` with full-screen `Box`
- Standard dialog fade animation
- No custom scrim animation

### 8.5 Error/Success Feedback

**No celebratory animations** when connected
**No shake/bounce** on connection error

### 8.6 Button Press Animation

**Material Ripple**:
- All buttons use default Material 3 ripple effect
- Touch feedback on device cards
- No custom scale or elevation change on press

---

## 9. DATA DISPLAY LOGIC

### 9.1 Device Name Formatting

**Source**: DeviceSelectorDialog line 493

```kotlin
Text(
    device.name,
    style = MaterialTheme.typography.bodyLarge,
    fontWeight = FontWeight.Bold,
    color = MaterialTheme.colorScheme.onSurface
)
```

**Logic**:
- Displays `device.name` **as-is** with no formatting
- No truncation (relies on text wrapping)
- No filtering or sanitization
- Example: "Vitruvian Trainer"

### 9.2 MAC Address Formatting

**Source**: DeviceSelectorDialog line 498

```kotlin
Text(
    device.address,
    style = MaterialTheme.typography.bodySmall,
    color = MaterialTheme.colorScheme.onSurfaceVariant
)
```

**Logic**:
- Displays `device.address` **as-is** with no formatting
- Assumes format: `"XX:XX:XX:XX:XX:XX"` (colon-separated)
- No validation or reformatting
- Example: "00:1A:7D:DA:71:13"

### 9.3 RSSI Signal Strength

**Data Captured** (ScannedDevice line 1747):
```kotlin
val rssi: Int = 0  // dBm (decibels milliwatt)
```

**Display**: **NOT DISPLAYED IN UI**
- RSSI value is collected but not shown
- No signal bars
- No signal percentage
- No "weak/strong" indicator

**Rationale**: Likely omitted for simplicity, but data is available for future enhancement

### 9.4 Connection State Determination

**Source**: MainViewModel line 55
```kotlin
val connectionState: StateFlow<ConnectionState> = bleRepository.connectionState
```

**Enum States** (from domain model):
```kotlin
sealed class ConnectionState {
    object Disconnected : ConnectionState()
    object Scanning : ConnectionState()
    object Connecting : ConnectionState()
    data class Connected(val deviceAddress: String) : ConnectionState()
    data class Error(val message: String) : ConnectionState()
}
```

**State Flow**:
1. **Disconnected** → Initial state, no device
2. **Scanning** → `bleRepository.startScanning()` called
3. **Connecting** → Device selected, attempting connection
4. **Connected** → BLE connection established
5. **Error** → Connection failed (timeout, BLE error, etc.)

**UI Mapping**:
- TopAppBar icon changes based on state
- Dialog shows scanning indicator when state = Scanning
- Overlay appears when `isAutoConnecting = true`

### 9.5 Device List Sorting/Filtering

**Sorting**: **NOT IMPLEMENTED**
- Devices appear in order discovered
- No sorting by name, RSSI, or connection history

**Filtering**: **IMPLIED (by device name)**
- Repository likely filters for "Vitruvian" in device name
- Not visible in UI layer code
- Would be in `VitruvianBleManager` or `BleRepositoryImpl`

### 9.6 Scan Results Management

**Source**: MainViewModel lines 542-554

```kotlin
fun startScanning() {
    viewModelScope.launch {
        _scannedDevices.value = emptyList()  // Clear previous results
        val result = bleRepository.startScanning()
        // ...
    }
}
```

**Logic**:
- Each scan **clears previous results** first
- Repository continuously emits discovered devices
- UI updates reactively as devices are found
- No deduplication logic visible (likely in repository)

---

## 10. STATE MANAGEMENT

### 10.1 All Possible UI States

**Connection States** (ConnectionState enum):
1. **Disconnected** - No active connection
2. **Scanning** - BLE scan in progress
3. **Connecting** - Connection attempt to specific device
4. **Connected** - Active BLE connection
5. **Error** - Connection failed

**Auto-Connect UI States** (MainViewModel):
1. **isAutoConnecting** (`Boolean`)
   - `false`: No auto-connect in progress
   - `true`: Auto-connect overlay visible
2. **connectionError** (`String?`)
   - `null`: No error
   - `"message"`: Error dialog visible

**Permission States** (PermissionRequestScreen):
1. **allPermissionsGranted** - Proceed to main UI
2. **!allPermissionsGranted** - Show permission request screen

**Scanned Devices State**:
1. **Empty list + isScanning** - Show "Scanning..." indicator
2. **Empty list + !isScanning** - Show "No devices found"
3. **Non-empty list** - Show device list

**Connection Lost State** (MainViewModel):
1. **connectionLostDuringWorkout** (`Boolean`)
   - `true`: Show critical alert dialog
   - `false`: No alert

### 10.2 State Transitions

**Connection Flow State Machine**:

```
Disconnected
    ↓ [User clicks connect OR workout start]
Scanning (auto-connect overlay appears)
    ↓ [Device discovered]
    ↓ [stopScanning()]
Connecting (overlay stays visible)
    ↓ [Connection established]
Connected (overlay disappears)
    ↓ [User clicks disconnect OR connection lost]
Disconnected

Error States (from any state):
    - Scan timeout (30s) → Error
    - Connection timeout (15s) → Error
    - BLE error → Error
    → [User dismisses] → Disconnected
```

**Auto-Connect Flow** (MainViewModel lines 586-671):
1. User triggers action requiring connection
2. Check current state:
   - If `Connected` → Proceed immediately
   - If not connected → Start auto-connect
3. Set `_isAutoConnecting = true` (show overlay)
4. Clear error: `_connectionError = null`
5. Start scanning: `startScanning()`
6. Wait for first device (30s timeout):
   - Success → Stop scan, connect to device
   - Timeout → Show error "Scan timeout - no device found"
7. Wait for connection (15s timeout):
   - Success → Call `onConnected()`, hide overlay
   - Timeout → Show error "Connection timeout", cancel BLE connection
8. Set `_isAutoConnecting = false` (hide overlay)

**User Cancellation**:
- Throws `CancellationException`
- Cleanup in `finally` block
- No error shown to user

### 10.3 How ViewModel Exposes State

**StateFlow Pattern**:
```kotlin
// Private mutable state
private val _scannedDevices = MutableStateFlow<List<ScannedDevice>>(emptyList())

// Public immutable state
val scannedDevices: StateFlow<List<ScannedDevice>> = _scannedDevices.asStateFlow()
```

**Collected States**:
- `connectionState: StateFlow<ConnectionState>` (from BleRepository)
- `scannedDevices: StateFlow<List<ScannedDevice>>`
- `isAutoConnecting: StateFlow<Boolean>`
- `connectionError: StateFlow<String?>`
- `connectionLostDuringWorkout: StateFlow<Boolean>`

**SharedFlow for Events**:
```kotlin
private val _hapticEvents = MutableSharedFlow<HapticEvent>(...)
val hapticEvents: SharedFlow<HapticEvent> = _hapticEvents.asSharedFlow()
```
(Not used for BLE connection UI, but present in ViewModel)

### 10.4 How UI Reacts to State Changes

**Compose collectAsState Pattern**:

```kotlin
// EnhancedMainScreen.kt line 44
val connectionState by viewModel.connectionState.collectAsState()

// UI recomposes when state changes
Icon(
    imageVector = when (connectionState) {
        is ConnectionState.Connected -> Icons.Default.Bluetooth
        is ConnectionState.Connecting -> Icons.Default.BluetoothSearching
        // ...
    }
)
```

**Conditional Rendering**:

```kotlin
// HomeScreen.kt lines 172-183
if (isAutoConnecting) {
    ConnectingOverlay(onCancel = { viewModel.cancelAutoConnecting() })
}

connectionError?.let { error ->
    ConnectionErrorDialog(
        message = error,
        onDismiss = { viewModel.clearConnectionError() }
    )
}
```

**LaunchedEffect for Side Effects**:
- Not used for BLE connection UI state
- State changes are purely declarative

---

## 11. BEHAVIORAL DETAILS

### 11.1 Auto-Scan on Screen Open

**NO** - Scanning does NOT start automatically when app opens

**Trigger Points**:
1. User clicks connection icon in TopAppBar
2. User starts workout (Just Lift, Single Exercise, etc.)
3. User taps "Connect" on Connection Status Banner
4. User taps "Reconnect" on Connection Lost Dialog

### 11.2 Auto-Connect to Last Device

**YES** - Auto-connect is implemented but not to "last device"

**Logic** (MainViewModel lines 604-614):
- Scan starts on connection request
- Connects to **first discovered device** matching filter
- Does **NOT** check device address against saved preference
- Does **NOT** prioritize previously connected devices

**Implementation**:
```kotlin
// Wait for first discovered device (with timeout)
val found = withTimeoutOrNull(30000) {
    scannedDevices
        .filter { it.isNotEmpty() }
        .take(1)  // Take first emitted non-empty list
        .collect { devices ->
            val device = devices.firstOrNull()  // First device in list
            if (device != null) {
                connectToDevice(device.address)
            }
        }
}
```

**Implication**: If multiple Vitruvian Trainers are in range, behavior is **non-deterministic** (depends on which is discovered first)

### 11.3 Scan Timeout Duration

**30 seconds** (MainViewModel line 605)

```kotlin
val found = withTimeoutOrNull(30000) { ... }
```

**Behavior on Timeout**:
- Stop scanning: `stopScanning()`
- Cancel BLE connection: `bleRepository.cancelConnection()`
- Hide overlay: `_isAutoConnecting = false`
- Show error: `_connectionError = "Scan timeout - no device found"`
- Call `onFailed()` callback

### 11.4 Connection Timeout Duration

**15 seconds** (MainViewModel line 617)

```kotlin
val connected = withTimeoutOrNull(15000) {
    connectionState
        .filter { it is ConnectionState.Connected }
        .take(1)
        .collect { }
    true
}
```

**Behavior on Timeout**:
- Cancel BLE connection: `bleRepository.cancelConnection()`
- Clear pending callback: `_pendingConnectionCallback = null`
- Hide overlay: `_isAutoConnecting = false`
- Show error: `_connectionError = "Connection timeout"`
- Call `onFailed()` callback

### 11.5 Retry Logic

**Manual Retry Only** - No automatic retry

**User-Initiated Retry**:
1. Connection fails → Error dialog appears
2. User taps "Retry" button (if provided)
3. Calls `onRetry()` callback
4. Full connection flow repeats

**No Exponential Backoff** or automatic retry attempts

### 11.6 Permission Handling Flow

**Permissions Required** (EnhancedMainScreen lines 68-80):

**Android 12+ (API 31+)**:
- `BLUETOOTH_SCAN`
- `BLUETOOTH_CONNECT`
- `ACCESS_FINE_LOCATION`

**Android 11 and below**:
- `BLUETOOTH`
- `BLUETOOTH_ADMIN`
- `ACCESS_FINE_LOCATION`

**Flow** (lines 357-372):
```kotlin
if (!permissionState.allPermissionsGranted) {
    PermissionRequestScreen(
        permissionState = permissionState,
        modifier = Modifier.padding(adjustedPadding)
    )
} else {
    NavGraph(...)  // Main app UI
}
```

**Permission Screen Behavior**:
1. App checks permissions on launch
2. If not granted → Show `PermissionRequestScreen`
3. User taps "Grant permissions" → System permission dialogs
4. If granted → Transition to main app
5. If denied → Stay on permission screen (user can try again)

**Runtime Permission Requests**:
- Uses `accompanist-permissions` library
- `rememberMultiplePermissionsState(permissions)`
- `launchMultiplePermissionRequest()`

### 11.7 Bluetooth Enable Prompt

**NOT IMPLEMENTED** in UI layer

**Assumption**: BLE repository handles enabling Bluetooth or returns error if disabled

**User Experience**:
- If Bluetooth disabled → Connection fails with error
- Error dialog shows troubleshooting tips
- User must manually enable Bluetooth in system settings

### 11.8 Empty State (No Devices Found)

**Display Condition** (DeviceSelectorDialog lines 451-471):
```kotlin
if (devices.isEmpty()) {
    Column(...) {
        if (isScanning) {
            // Show scanning indicator
            CircularProgressIndicator(...)
            Text("Scanning...")
        } else {
            // Show empty state
            Text("No devices found. Try scanning again.")
        }
    }
}
```

**User Actions**:
- Tap "Rescan" button to try again
- Tap "Cancel" to dismiss dialog

### 11.9 Background Scanning

**Scanning Continues** after dialog dismissed (Cancel button)

**Connection Cancellation**:
- If user taps "Cancel" on **Connecting Overlay**:
  - Scanning stops
  - BLE connection cancelled
  - All state cleared
- If user taps "Cancel" on **Device Selector Dialog**:
  - Dialog dismisses
  - Scanning **continues in background** (potential bug/UX issue)

### 11.10 Multiple Devices Handling

**Device Selector Dialog** supports multiple devices:
- `LazyColumn` displays all discovered devices
- User must manually select device
- Only used if auto-connect is **not** triggered

**Auto-Connect**:
- Connects to **first discovered device**
- Dialog **never shown** in auto-connect flow
- User has no choice if multiple devices present

---

## 12. CODE SNIPPETS

### 12.1 Main Composable Functions

#### DeviceSelectorDialog (Complete)

**Source**: EnhancedMainScreen.kt lines 439-531

```kotlin
@Composable
fun DeviceSelectorDialog(
    devices: List<ScannedDevice>,
    isScanning: Boolean,
    onDeviceSelected: (ScannedDevice) -> Unit,
    onRescan: () -> Unit,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Select Vitruvian Device") },
        text = {
            Column(modifier = Modifier.fillMaxWidth()) {
                if (devices.isEmpty()) {
                    Column(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(Spacing.medium),
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        if (isScanning) {
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                CircularProgressIndicator(modifier = Modifier.size(18.dp))
                                Spacer(modifier = Modifier.width(Spacing.small))
                                Text("Scanning...")
                            }
                        } else {
                            Text(
                                "No devices found. Try scanning again.",
                                color = MaterialTheme.colorScheme.onSurfaceVariant,
                                textAlign = TextAlign.Center
                            )
                        }
                    }
                }

                if (devices.isNotEmpty()) {
                    LazyColumn(verticalArrangement = Arrangement.spacedBy(Spacing.extraSmall)) {
                        items(devices, key = { it.address }) { device ->
                            Card(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .clickable { onDeviceSelected(device) },
                                colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surfaceVariant),
                                shape = RoundedCornerShape(16.dp)
                            ) {
                                Row(
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .padding(Spacing.medium),
                                    horizontalArrangement = Arrangement.SpaceBetween,
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Column(modifier = Modifier.weight(1f)) {
                                        Text(
                                            device.name,
                                            style = MaterialTheme.typography.bodyLarge,
                                            fontWeight = FontWeight.Bold,
                                            color = MaterialTheme.colorScheme.onSurface
                                        )
                                        Text(
                                            device.address,
                                            style = MaterialTheme.typography.bodySmall,
                                            color = MaterialTheme.colorScheme.onSurfaceVariant
                                        )
                                    }
                                    Icon(
                                        Icons.AutoMirrored.Filled.KeyboardArrowRight,
                                        contentDescription = null,
                                        tint = MaterialTheme.colorScheme.primary
                                    )
                                }
                            }
                        }
                    }
                }
            }
        },
        confirmButton = {
            if (!isScanning) {
                TextButton(onClick = onRescan) {
                    Icon(Icons.Default.Refresh, contentDescription = "Rescan for devices", modifier = Modifier.size(18.dp), tint = MaterialTheme.colorScheme.primary)
                    Spacer(modifier = Modifier.width(Spacing.extraSmall))
                    Text("Rescan", color = MaterialTheme.colorScheme.primary)
                }
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel", color = MaterialTheme.colorScheme.onSurfaceVariant)
            }
        }
    )
}
```

#### ConnectingOverlay (Complete)

**Source**: ConnectingOverlay.kt lines 22-71

```kotlin
@Composable
fun ConnectingOverlay(
    onCancel: () -> Unit = {}
) {
    Dialog(
        onDismissRequest = { /* Non-dismissible */ },
        properties = DialogProperties(
            dismissOnBackPress = false,
            dismissOnClickOutside = false,
            usePlatformDefaultWidth = false
        )
    ) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.scrim.copy(alpha = 0.6f)),
            contentAlignment = Alignment.Center
        ) {
            Card(
                modifier = Modifier
                    .padding(32.dp)
                    .wrapContentSize()
            ) {
                Column(
                    modifier = Modifier.padding(32.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    CircularProgressIndicator(
                        modifier = Modifier.size(48.dp)
                    )
                    Text(
                        "Connecting to device...",
                        style = MaterialTheme.typography.titleMedium
                    )
                    Text(
                        "Scanning for Vitruvian Trainer",
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    TextButton(
                        onClick = onCancel,
                        modifier = Modifier.padding(top = 8.dp)
                    ) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}
```

#### ConnectionStatusBanner (Complete)

**Source**: ConnectionStatusBanner.kt lines 24-77

```kotlin
@Composable
fun ConnectionStatusBanner(
    onConnect: () -> Unit,
    modifier: Modifier = Modifier
) {
    Card(
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = Spacing.medium, vertical = Spacing.small),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceContainerHighest
        ),
        shape = MaterialTheme.shapes.medium
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(Spacing.medium),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Status icon and message
            Row(
                modifier = Modifier.weight(1f),
                horizontalArrangement = Arrangement.spacedBy(Spacing.small),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    imageVector = Icons.Default.Bluetooth,
                    contentDescription = null,
                    tint = MaterialTheme.colorScheme.error,
                    modifier = Modifier.size(24.dp)
                )
                Text(
                    text = "Not connected to machine",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurface,
                    fontWeight = FontWeight.Medium
                )
            }

            // Connect button
            TextButton(
                onClick = onConnect,
                modifier = Modifier.padding(start = Spacing.medium)
            ) {
                Text(
                    "Connect",
                    style = MaterialTheme.typography.labelLarge,
                    fontWeight = FontWeight.Bold
                )
            }
        }
    }
}
```

#### TopAppBar Connection Status (Snippet)

**Source**: EnhancedMainScreen.kt lines 108-179

```kotlin
TopAppBar(
    // ... title omitted ...
    actions = {
        // Connection status icon (Bluetooth) with text label
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center,
            modifier = Modifier
                .padding(horizontal = 4.dp)
                .defaultMinSize(minWidth = 48.dp, minHeight = 48.dp)
                .clickable(
                    onClick = {
                        if (connectionState is ConnectionState.Connected) {
                            viewModel.disconnect()
                        } else {
                            viewModel.ensureConnection(
                                onConnected = {},
                                onFailed = {}
                            )
                        }
                    },
                    role = androidx.compose.ui.semantics.Role.Button
                )
        ) {
            Icon(
                imageVector = when (connectionState) {
                    is ConnectionState.Connected -> Icons.Default.Bluetooth
                    is ConnectionState.Connecting -> Icons.Default.BluetoothSearching
                    is ConnectionState.Disconnected -> Icons.Default.BluetoothDisabled
                    is ConnectionState.Scanning -> Icons.Default.BluetoothSearching
                    is ConnectionState.Error -> Icons.Default.BluetoothDisabled
                },
                contentDescription = when (connectionState) {
                    is ConnectionState.Connected -> "Connected to machine. Tap to disconnect"
                    is ConnectionState.Connecting -> "Connecting to machine"
                    is ConnectionState.Disconnected -> "Disconnected. Tap to connect"
                    is ConnectionState.Scanning -> "Scanning for machine"
                    is ConnectionState.Error -> "Connection error. Tap to retry"
                },
                tint = when (connectionState) {
                    is ConnectionState.Connected -> Color(0xFF22C55E) // green-500
                    is ConnectionState.Connecting -> Color(0xFFFBBF24) // yellow-400
                    is ConnectionState.Disconnected -> Color(0xFFEF4444) // red-500
                    is ConnectionState.Scanning -> Color(0xFF3B82F6) // blue-500
                    is ConnectionState.Error -> Color(0xFFEF4444) // red-500
                },
                modifier = Modifier.size(20.dp)
            )
            Text(
                text = when (connectionState) {
                    is ConnectionState.Connected -> "Connected"
                    is ConnectionState.Connecting -> "Connecting"
                    is ConnectionState.Disconnected -> "Disconnected"
                    is ConnectionState.Scanning -> "Scanning"
                    is ConnectionState.Error -> "Error"
                },
                style = MaterialTheme.typography.labelSmall.copy(fontSize = 9.sp),
                color = when (connectionState) {
                    is ConnectionState.Connected -> Color(0xFF22C55E)
                    is ConnectionState.Connecting -> Color(0xFFFBBF24)
                    is ConnectionState.Disconnected -> Color(0xFFEF4444)
                    is ConnectionState.Scanning -> Color(0xFF3B82F6)
                    is ConnectionState.Error -> Color(0xFFEF4444)
                },
                maxLines = 1
            )
        }

        // Theme toggle (omitted)
    }
)
```

### 12.2 Device List Item Composable

**See DeviceSelectorDialog above** - Device items are inline in the LazyColumn (lines 476-512)

### 12.3 Scan Button Composable

**See DeviceSelectorDialog above** - Scan button is inline in confirmButton (lines 516-524)

### 12.4 Connection State Handling

#### ViewModel Connection State

**Source**: MainViewModel.kt lines 586-671

```kotlin
/**
 * Ensures BLE connection before proceeding with callback.
 * If already connected, immediately calls onConnected.
 * If not connected, starts scan and shows device selection dialog.
 */
fun ensureConnection(onConnected: () -> Unit, onFailed: () -> Unit = {}) {
    // Cancel any existing connection attempt before starting a new one
    connectionJob?.cancel()
    connectionJob = null

    connectionJob = viewModelScope.launch {
        try {
            when (connectionState.value) {
                is ConnectionState.Connected -> {
                    onConnected()
                }
                else -> {
                    _isAutoConnecting.value = true
                    _connectionError.value = null

                    // Start scanning
                    startScanning()

                    // Wait for first discovered device (with timeout)
                    val found = withTimeoutOrNull(30000) {
                        scannedDevices
                            .filter { it.isNotEmpty() }
                            .take(1)
                            .collect { devices ->
                                stopScanning()
                                val device = devices.firstOrNull()
                                if (device != null) {
                                    _pendingConnectionCallback = onConnected
                                    connectToDevice(device.address)

                                    // Wait for Connected state with timeout (15 seconds)
                                    val connected = withTimeoutOrNull(15000) {
                                        connectionState
                                            .filter { it is ConnectionState.Connected }
                                            .take(1)
                                            .collect { }
                                        true // Return true if we got Connected
                                    }

                                    _isAutoConnecting.value = false
                                    if (connected == true) {
                                        onConnected()
                                    } else {
                                        // Connection timeout or failure - clean up BLE connection
                                        Timber.d("Connection timeout or failure - cleaning up")
                                        bleRepository.cancelConnection()
                                        _pendingConnectionCallback = null
                                        _connectionError.value = "Connection timeout"
                                        onFailed()
                                    }
                                } else {
                                    _pendingConnectionCallback = null
                                    _isAutoConnecting.value = false
                                    _connectionError.value = "No device found"
                                    onFailed()
                                }
                            }
                    }

                    if (found == null) {
                        // Scan timeout - clean up properly
                        Timber.d("Scan timeout reached - cleaning up")
                        _pendingConnectionCallback = null
                        stopScanning()
                        bleRepository.cancelConnection()
                        _isAutoConnecting.value = false
                        _connectionError.value = "Scan timeout - no device found"
                        onFailed()
                    }
                }
            }
        } catch (e: kotlinx.coroutines.CancellationException) {
            // User explicitly cancelled - clean up without showing errors
            Timber.d("Connection attempt cancelled by user")
            stopScanning()
            bleRepository.cancelConnection()
            _isAutoConnecting.value = false
            _pendingConnectionCallback = null
            // Don't show error or call onFailed() - user cancelled intentionally
            throw e  // Re-throw to properly cancel the coroutine
        } finally {
            // Always clear job reference when coroutine completes
            connectionJob = null
        }
    }
}
```

#### UI State Collection

**Source**: HomeScreen.kt lines 49-52, 172-183

```kotlin
// Collect connection state
val connectionState by viewModel.connectionState.collectAsState()
val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
val connectionError by viewModel.connectionError.collectAsState()

// ... later in composable body ...

// Auto-connect UI overlays
if (isAutoConnecting) {
    ConnectingOverlay(
        onCancel = { viewModel.cancelAutoConnecting() }
    )
}

connectionError?.let { error ->
    ConnectionErrorDialog(
        message = error,
        onDismiss = { viewModel.clearConnectionError() }
    )
}
```

### 12.5 Key ViewModel State/Methods

#### State Properties

```kotlin
// Connection state from repository
val connectionState: StateFlow<ConnectionState> = bleRepository.connectionState

// Scanned devices
private val _scannedDevices = MutableStateFlow<List<ScannedDevice>>(emptyList())
val scannedDevices: StateFlow<List<ScannedDevice>> = _scannedDevices.asStateFlow()

// Auto-connect UI state
private val _isAutoConnecting = MutableStateFlow(false)
val isAutoConnecting: StateFlow<Boolean> = _isAutoConnecting.asStateFlow()

private val _connectionError = MutableStateFlow<String?>(null)
val connectionError: StateFlow<String?> = _connectionError.asStateFlow()

// Connection lost during workout alert
private val _connectionLostDuringWorkout = MutableStateFlow(false)
val connectionLostDuringWorkout: StateFlow<Boolean> = _connectionLostDuringWorkout.asStateFlow()

// Pending callback for after connection completes
private var _pendingConnectionCallback: (() -> Unit)? = null

// Track connection attempt for cancellation
private var connectionJob: Job? = null
```

#### Key Methods

```kotlin
// Start BLE scanning
fun startScanning() {
    viewModelScope.launch {
        _scannedDevices.value = emptyList()
        val result = bleRepository.startScanning()
        // Error handling omitted
    }
}

// Stop BLE scanning
fun stopScanning() {
    viewModelScope.launch {
        bleRepository.stopScanning()
    }
}

// Connect to specific device
fun connectToDevice(deviceAddress: String) {
    viewModelScope.launch {
        val result = bleRepository.connectToDevice(deviceAddress)
        if (result.isFailure) {
            Timber.e("Failed to connect: ${result.exceptionOrNull()?.message}")
        } else {
            // Wait for connection established
            connectionState
                .filter { it is ConnectionState.Connected }
                .take(1)
                .collect {
                    _pendingConnectionCallback?.invoke()
                    _pendingConnectionCallback = null
                }
        }
    }
}

// Disconnect from device
fun disconnect() {
    viewModelScope.launch {
        bleRepository.disconnect()
    }
}

// Clear connection error dialog
fun clearConnectionError() {
    _connectionError.value = null
}

// Cancel auto-connect process
fun cancelAutoConnecting() {
    connectionJob?.cancel()
    connectionJob = null
}

// Dismiss connection lost alert
fun dismissConnectionLostAlert() {
    _connectionLostDuringWorkout.value = false
}
```

---

## 13. FLUTTER IMPLEMENTATION NOTES

### Key Differences to Consider

1. **Permission Handling**:
   - Use `permission_handler` package in Flutter
   - Different permission models per platform (Android, iOS, etc.)
   - iOS requires Bluetooth usage descriptions in Info.plist

2. **BLE Package**:
   - Use `flutter_blue_plus` (recommended)
   - API differs from Nordic Android BLE Library
   - Stream-based device discovery

3. **State Management**:
   - Replace ViewModels with Riverpod `StateNotifier`
   - Use `StreamProvider` for BLE device streams
   - Replace `StateFlow` with `Stream` or `StateNotifier`

4. **Material 3 in Flutter**:
   - Flutter Material 3 typography slightly different
   - Use `useMaterial3: true` in ThemeData
   - Some color scheme properties map differently

5. **Animations**:
   - Replace Material Compose animations with Flutter `AnimatedWidget`
   - `CircularProgressIndicator` is built-in

6. **Dialog API**:
   - Use `showDialog()` with `AlertDialog` widget
   - Full-screen dialogs use `Dialog` with `InsetPadding: EdgeInsets.zero`

7. **Async/Await**:
   - Kotlin coroutines → Dart async/await
   - `Flow` → `Stream`
   - `viewModelScope.launch` → `Future` or `async`

8. **Platform Differences**:
   - iOS BLE requires different UUIDs and service discovery
   - Windows/macOS/Linux BLE support varies by `flutter_blue_plus` version

### Recommended Flutter Packages

```yaml
dependencies:
  flutter_blue_plus: ^1.32.0  # BLE connectivity
  riverpod: ^2.5.0            # State management
  permission_handler: ^11.0.0 # Runtime permissions
  freezed: ^2.4.0             # Immutable models

dev_dependencies:
  build_runner: ^2.4.0
  freezed_annotation: ^2.4.0
```

---

## 14. CRITICAL DESIGN DECISIONS

### 14.1 No Dedicated BLE Screen

**Decision**: BLE connection UI is **distributed** across multiple components rather than a dedicated "Connection Screen"

**Rationale**:
- Minimizes user friction
- Auto-connect on workout start (seamless UX)
- Connection status always visible in TopAppBar
- Reduces number of screens to navigate

**Implication for Flutter Port**:
- Must replicate distributed UI pattern
- Cannot create single "BleConnectionScreen" widget
- Need equivalent overlay/dialog system

### 14.2 Auto-Connect First Device

**Decision**: Auto-connect to first discovered device rather than showing device list

**Rationale**:
- Most users have only one Vitruvian Trainer
- Faster workout start (no manual selection)
- Simpler user flow

**Risk**:
- If multiple devices in range, may connect to wrong one
- No user control in auto-connect flow

**Mitigation**:
- BLE repository likely filters by device name ("Vitruvian")
- User can manually disconnect and retry

### 14.3 No RSSI Display

**Decision**: Capture RSSI data but don't display signal strength in UI

**Rationale**:
- Simplifies UI
- RSSI fluctuates rapidly (poor UX to show)
- Users don't need to know signal strength (binary: works or doesn't)

**Future Enhancement**:
- Could add signal bars if user reports frequent disconnections
- Could sort devices by RSSI (strongest first)

### 14.4 Non-Dismissible Connecting Overlay

**Decision**: Connecting overlay cannot be dismissed by tapping outside or back button

**Rationale**:
- Prevents accidental cancellation during critical connection phase
- Forces user to explicitly tap "Cancel" button

**User Experience**:
- Protects against accidental workflow interruption
- Makes cancel action deliberate

### 14.5 Scanning Continues After Dialog Dismiss

**Decision**: Tapping "Cancel" on device selector dialog dismisses dialog but **does NOT stop scanning**

**Potential Issue**:
- Scanning continues in background (battery drain)
- User may not be aware scanning is still active
- Possible bug or design oversight

**Recommendation for Flutter Port**:
- Consider stopping scan when dialog is dismissed
- OR show toast/snackbar: "Scanning in background"

---

## 15. ACCESSIBILITY CONSIDERATIONS

1. **Touch Targets**: Connection icon has `minSize(48dp, 48dp)` for accessibility
2. **Content Descriptions**: All icons have descriptive `contentDescription`
3. **Semantic Roles**: Connection icon marked with `role = Button`
4. **Color Independence**: Status conveyed through icon **and** text (not just color)
5. **Readable Text Sizes**: Minimum 11sp (labelSmall), most text 12-16sp
6. **Contrast**: Dark purple TopAppBar ensures white text has sufficient contrast

**Flutter Accessibility Mapping**:
- `contentDescription` → `Semantics(label: ...)`
- `role` → `Semantics(button: true)`
- Touch targets → `SizedBox(width: 48, height: 48)` wrapper

---

## 16. TESTING CONSIDERATIONS

### Manual Testing Requirements

1. **Bluetooth Off**: Verify error handling when Bluetooth disabled
2. **No Devices in Range**: Verify empty state and timeout behavior
3. **Multiple Devices**: Verify auto-connect chooses first device
4. **Mid-Connection Cancel**: Verify cancel button properly stops connection
5. **Connection Lost**: Simulate connection drop during workout
6. **Permission Denial**: Verify app handles permission rejection gracefully
7. **Scan Timeout**: Verify 30-second timeout shows correct error
8. **Connection Timeout**: Verify 15-second timeout shows correct error

### Unit Test Targets

1. **ScannedDevice Model**: Verify data class properties
2. **State Transitions**: Test `ensureConnection()` state flow
3. **Timeout Handling**: Test `withTimeoutOrNull` behavior
4. **Cancellation**: Test `cancelAutoConnecting()` cleanup

### Widget Test Targets

1. **DeviceSelectorDialog**: Verify empty state vs device list rendering
2. **ConnectingOverlay**: Verify cancel button interaction
3. **ConnectionStatusBanner**: Verify connect button callback
4. **TopAppBar Icon**: Verify state-based icon/color switching

---

## 17. SUMMARY

The BLE Connection UI in VitruvianRedux is a **distributed system** combining:

1. **TopAppBar Status Indicator** - Always-visible connection state
2. **Auto-Connect Overlay** - Modal connection progress with cancel
3. **Device Selector Dialog** - Manual device selection (rarely used)
4. **Error Dialogs** - Connection failures with troubleshooting
5. **Warning Banners** - Persistent disconnected state notification

**Key Characteristics**:
- **Auto-connect first**: Scan → first device → connect (30s scan + 15s connection timeout)
- **No signal strength display**: RSSI captured but not shown
- **Material 3 styling**: Purple theme, proper spacing, accessibility
- **State-driven UI**: Reactive to `ConnectionState` changes
- **Distributed UI**: No dedicated BLE screen, components used contextually

**Flutter Port Strategy**:
1. Replicate exact component structure (overlay, dialogs, banner)
2. Use `flutter_blue_plus` for BLE (map Nordic BLE API)
3. Use Riverpod `StateNotifier` for connection state management
4. Use `StreamProvider` for scanned devices
5. Preserve exact colors, spacing, and typography
6. Implement same timeout values (30s scan, 15s connect)
7. Replicate auto-connect flow exactly

---

**Document Version**: 1.0
**Last Updated**: 2025-11-12
**Source Project**: VitruvianRedux (Kotlin/Jetpack Compose)
**Target Project**: VPP_Flutter_Port (Flutter/Dart)

---
