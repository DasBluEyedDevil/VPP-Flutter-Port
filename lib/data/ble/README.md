# BLE Layer - Phase 1 (Week 1-3)

Critical path for the entire project. Must be tested with hardware before proceeding.

## Files to Port

1. **constants.dart** ← Constants.kt
   - All BLE UUIDs (NUS Service + characteristics)
   - Protocol constants and timeouts
   - Magic numbers and thresholds

2. **protocol_builder.dart** ← ProtocolBuilder.kt
   - INIT command (0x0A)
   - INIT_PRESET command (0x11)
   - PROGRAM_PARAMS command (0x04) - 96 bytes
   - ECHO_CONTROL command (0x13) - 40 bytes
   - COLOR_SCHEME command (0x1D) - 44 bytes
   - **CRITICAL:** Cannot split frames

3. **vitruvian_ble_manager.dart** ← VitruvianBleManager.kt (745 lines)
   - Device scanning and filtering
   - Connection management with auto-reconnect
   - MTU negotiation (247 bytes)
   - Service/characteristic discovery
   - Polling system (Monitor @100ms, Property @500ms)
   - Data parsing (Monitor → WorkoutMetric, RepNotify → events)
   - Handle state detection (hysteresis algorithm)

4. **device_info.dart** ← DeviceInfo.kt
5. **hardware_detection.dart** ← HardwareDetection.kt

## Implementation Notes

- Use flutter_blue_plus instead of Nordic BLE library
- Polling must be exactly 100ms for Monitor characteristic
- MTU negotiation critical (247 bytes)
- Frame integrity: CANNOT split protocol frames
- All protocol bytes must match Kotlin implementation exactly
