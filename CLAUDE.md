# ALWAYS USE THE QUADRUMVIRATE FOR ANY AND ALL TASKS TO PRESERVE YOUR TOKEN COUNT

# VPP_Flutter_Port - Claude Code Project Instructions

This file contains project-specific instructions for Claude Code when working on the VPP_Flutter_Port project (Vitruvian Project Phoenix - Flutter Port).

## Session Start Protocol

**MANDATORY: Always start each session by:**
1. Reading `LAST_SESSION.md` for immediate context
2. Reading recent entries in `CHANGELOG.md` (last 3-5 sessions)
3. Checking DevilMCP project context
4. Reviewing any in-progress TODOs or documented next steps

## AI Quadrumvirate Orchestration System

**Your Role: The Orchestrator (Strategist & Architect)**

You coordinate all work but perform minimal direct implementation to conserve tokens. Your value is in orchestration and decision-making, not in reading files or writing code.

### The Four Roles

1. **Claude (You)** - Orchestrator: Requirements, planning, specs, coordination
2. **Gemini CLI** - Researcher (The Eyes): Code analysis, unlimited context (1M+ tokens)
3. **Cursor CLI** - Engineer #1: UI/Flutter widgets, complex reasoning
4. **Copilot CLI** - Engineer #2: Backend, BLE, Dart services, GitHub operations

### Token Conservation Rules

#### ❌ NEVER
- Read files >100 lines (ask Gemini instead)
- Implement complex features directly (delegate to Cursor/Copilot)
- Review code yourself (ask Gemini specific questions)
- Analyze directories (use Gemini's 1M context)
- Use Glob/Grep for exploration (use Gemini via Task tool or wrapper script)

#### ✅ ALWAYS
- Use Superpowers skills for structured workflows
- Delegate implementation to Cursor/Copilot subagents
- Delegate documentation creation to Gemini (specs, guides, README files)
- Ask Gemini before reading any code
- Use TodoWrite for task tracking
- Use DevilMCP for all decision logging and change tracking
- ONLY perform trivial edits (<5 lines)

### Wrapper Scripts

All three CLIs have wrapper scripts in `.skills/`:
- `.skills/gemini.agent.wrapper.sh` - For code analysis (both Kotlin source and Flutter target)
- `.skills/cursor.agent.wrapper.sh` - For UI/Flutter widgets/complex reasoning
- `.skills/copilot.agent.wrapper.sh` - For backend/BLE/Dart/GitHub ops

See `.skills/flutter-orchestrator.md` for detailed delegation patterns.

## DevilMCP Integration

**CRITICAL: Use DevilMCP for all decision tracking and context persistence**

### Before Making Any Decision
```dart
mcp__devilmcp__query_decisions  // Check past decisions
mcp__devilmcp__log_decision     // Log new decisions with rationale
```

### Before Porting a File
```dart
mcp__devilmcp__track_file_dependencies  // Analyze dependencies
mcp__devilmcp__analyze_change_impact    // Understand blast radius
mcp__devilmcp__log_change               // Log the porting work
```

### After Completing Work
```dart
mcp__devilmcp__update_change_status     // Update change status
mcp__devilmcp__update_decision_outcome  // Log actual outcomes
```

## Project Overview

**VPP_Flutter_Port** is a direct port of the VitruvianRedux Kotlin Android app to Flutter/Dart for native multi-platform support (Android, iOS, Windows, macOS, Linux). This is a sophisticated BLE fitness tracking app for controlling Vitruvian resistance training machines.

**Source Project:** `C:\Users\dasbl\AndroidStudioProjects\VitruvianRedux`
**Target Project:** `C:\Users\dasbl\AndroidStudioProjects\VPP_Flutter_Port`

**Current Status:** Phase 0 - Planning and Setup Complete
**Version:** 0.1.0-alpha
**Target Platforms:** Android, iOS, Windows, macOS, Linux

### Core Functionality (Must Port Everything)
- **BLE Connectivity**: Connect to Vitruvian devices via BLE (100Hz polling)
- **Workout Tracking**: Real-time workout monitoring with rep counting
- **Just Lift Mode**: Auto-start/auto-stop based on handle detection
- **Routine Management**: Create, edit, execute workout routines
- **Weekly Programs**: Assign routines to days of the week
- **Personal Records**: Track and celebrate PRs
- **Analytics**: Charts and workout history analysis
- **Settings**: User preferences and app configuration

### Technology Stack

**Source (Kotlin):**
- Kotlin 1.9+, Jetpack Compose, Coroutines/Flow
- Nordic BLE Library, Room ORM, Hilt DI
- MVVM + Clean Architecture

**Target (Flutter/Dart):**
- Flutter 3.9+, Dart 3.9+
- flutter_blue_plus (BLE)
- Drift (database, replaces Room)
- Riverpod (state management + DI, replaces ViewModels + Hilt)
- Material 3 UI
- Clean Architecture (domain/data/presentation layers)

### Architecture Decisions

All major decisions logged in DevilMCP. Key choices:
1. **Strategy:** BLE-First (Bottom-Up) - Port BLE layer first, then build up
2. **State Management:** Riverpod (StateNotifierProvider + StreamProvider)
3. **Database:** Drift (type-safe, Room-like)
4. **BLE Package:** flutter_blue_plus
5. **Structure:** Mirror Kotlin Clean Architecture exactly
6. **Tracking:** Dual system (PORTING_PROGRESS.md + DevilMCP)
7. **Phases:** 5 detailed phases (BLE → Domain → Data → State → UI)

## Porting Strategy

### Five-Phase Implementation Plan

**Phase 1: BLE Infrastructure (Week 1-3)**
- Port Constants, ProtocolBuilder, VitruvianBleManager
- Test with hardware: connect, poll @100Hz, parse data

**Phase 2: Domain Models (Week 4)**
- Port all domain models and business logic
- Unit test rep counter algorithm

**Phase 3: Data Layer (Week 5-7)**
- Port database schema (10 tables) to Drift
- Port all repositories
- Test database performance (100Hz inserts)

**Phase 4: State Management (Week 8-10)**
- Port ViewModels to Riverpod providers
- Set up dependency injection
- Integration tests

**Phase 5: UI Layer (Week 11-16)**
- Port 19 screens to Flutter widgets
- Port 13 reusable components
- Widget tests, manual testing with hardware

**Timeline:** 16-20 weeks for complete port

### File Tracking

**PORTING_PROGRESS.md** - Visual checklist of all 71 Kotlin files
- Not Started → In Progress → Ported → Tested
- Update after each file completion

**DevilMCP** - Detailed change log
- Log every file port with `log_change`
- Track dependencies and impacts
- Query past work for patterns

## Typical Workflow (Token-Efficient)

### 1. File Selection (You - ~500 tokens)
- Check PORTING_PROGRESS.md for next file
- Query DevilMCP for dependencies
- Create TodoWrite plan

### 2. Source Analysis (Gemini - 0 your tokens)
```bash
.skills/gemini.agent.wrapper.sh -d "@C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/" "
Analyze the Kotlin file: [path]

Provide:
1. Complete code with explanations
2. Dependencies and imports
3. Key logic and algorithms
4. Edge cases and quirks
5. How it integrates with other files

Format output for easy Dart translation."
```

### 3. Translation Delegation (You - ~1k tokens)
**For UI/Widgets (Cursor):**
```bash
.skills/cursor.agent.wrapper.sh "FLUTTER PORTING TASK:

**Source File:** [Kotlin file path]
**Target File:** [Dart file path]

**Kotlin Code:**
[paste Gemini's analysis]

**Requirements:**
- Direct 1:1 port to Flutter/Dart
- Use Riverpod for state
- Follow Material 3 guidelines
- Preserve all functionality

**After Completion:**
1. Run flutter analyze
2. Run tests
3. Update PORTING_PROGRESS.md
4. Report changes"
```

**For Backend/BLE (Copilot):**
```bash
.skills/copilot.agent.wrapper.sh --allow-write "DART PORTING TASK:

**Source File:** [Kotlin file path]
**Target File:** [Dart file path]

**Kotlin Code:**
[paste Gemini's analysis]

**Requirements:**
- Direct 1:1 port to Dart
- Preserve protocol exactly (critical for BLE)
- Use async/await instead of coroutines
- Match ByteBuffer behavior with ByteData

**After Completion:**
1. Run dart analyze
2. Run unit tests
3. Update PORTING_PROGRESS.md
4. Report changes"
```

### 4. Verification (Gemini + You - ~1k tokens)
```bash
.skills/gemini.agent.wrapper.sh "
Compare Kotlin source and Dart port:
- Kotlin: [path]
- Dart: [path]

Verify:
1. All functionality preserved
2. Logic correctness
3. Edge cases handled
4. Performance acceptable"

# Then: superpowers:verification-before-completion
```

**Total Your Tokens**: ~3k per file (vs 15k+ old approach - **80% savings!**)

## Technical Reference Skills

**IMPORTANT:** For detailed technical information, invoke these skills:

### vitruvian-flutter-ble
**Use when:** Working on BLE connectivity, protocol implementation, debugging
**Contains:**
- flutter_blue_plus usage patterns
- BLE UUIDs and characteristics (from Kotlin)
- Connection sequence for Flutter
- Protocol frame specifications
- 100Hz polling implementation
- Stream handling for BLE data

### vitruvian-flutter-architecture
**Use when:** Planning features, understanding data flow, architectural decisions
**Contains:**
- Clean Architecture in Flutter context
- Riverpod patterns (replacing ViewModels)
- Drift database patterns (replacing Room)
- Repository pattern in Dart
- State management flow
- Dependency injection with Riverpod

### vitruvian-kotlin-reference
**Use when:** Need to understand source Kotlin implementation
**Contains:**
- Kotlin → Dart translation guide
- Common pattern mappings
- Protocol quirks and critical details
- Testing requirements

## Coding Standards

### Dart/Flutter Best Practices
- Use modern Dart idioms (async/await, streams, sealed classes)
- Prefer immutability with freezed or built_value
- Leverage Dart's null safety
- Use extension methods for utilities
- Follow effective Dart guidelines

### Architecture Patterns
- **Clean Architecture**: Presentation → Domain → Data layers
- **State Management**: Riverpod with StateNotifier pattern
- **Repository Pattern**: Abstract data sources behind repositories
- **Dependency Injection**: Riverpod providers
- **Single Source of Truth**: StateNotifier for state management
- **Unidirectional Data Flow**: Events up, state down

### Async Operations
- Use `async`/`await` for async operations (replaces Kotlin suspend)
- Use `Stream` for data streams (replaces Flow)
- Use `StreamProvider` for BLE streams
- Properly manage stream subscriptions (dispose)

### BLE Guidelines (Summary)
- Always handle connection lifecycle carefully
- Implement timeout mechanisms (connection: 15s, operations: 5s, scan: 30s)
- Log all BLE operations for debugging
- **CRITICAL**: Monitor data requires active polling (100ms intervals)
- Always check connection state before operations
- Use StreamProvider to expose BLE streams to UI

**For detailed BLE implementation:** Invoke `vitruvian-flutter-ble` skill

### UI (Flutter Widgets)
- Keep widgets pure and stateless when possible
- Use ConsumerWidget for Riverpod state
- Use proper lifecycle management
- Follow Material 3 design guidelines

### Testing
- **Unit Tests**: Test business logic and domain models
- **Widget Tests**: Test UI components
- **Integration Tests**: Test complete features
- **IMPORTANT**: BLE functionality requires physical device for testing

### Error Handling
- Use Result/Either types for operations that can fail
- Log errors with context
- Provide user-friendly error messages
- Handle edge cases explicitly

## Git Workflow

### Branch Strategy
- **main**: Production-ready code (don't commit directly)
- **working_branch**: Current development branch
- Feature branches: Create from main for significant features

### Commit Messages
Follow conventional commits format:
```
type(scope): description

[optional body]

[optional footer]
```

Types: feat, fix, refactor, test, docs, chore, style, perf, port

### Before Committing
1. Run tests: `flutter test`
2. Run lint: `flutter analyze`
3. Ensure builds: `flutter build apk --debug`
4. Update CHANGELOG.md
5. Update LAST_SESSION.md
6. Update PORTING_PROGRESS.md

## Common Quick Commands

### Build & Run
```bash
flutter pub get                  # Install dependencies
flutter run                      # Run on connected device
flutter build apk --debug        # Build Android APK
flutter build ios                # Build iOS (macOS only)
```

### Testing & Quality
```bash
flutter test                     # Run unit/widget tests
flutter analyze                  # Run static analysis
dart format .                    # Format code
```

### Debugging
```bash
flutter logs                     # View logs
flutter doctor                   # Check setup
```

## Important Constraints

1. **Protocol Compatibility:** All BLE frames must EXACTLY match Kotlin implementation. Cannot modify protocol bytes.

2. **Hardware Required:** Most functionality cannot be tested without physical Vitruvian Trainer.

3. **Monitor Polling:** Device does NOT send notifications for metrics. MUST actively poll every 100ms.

4. **Threading:** Use async/await and streams, never block main isolate.

5. **Permissions:** Handle runtime Bluetooth permissions on all platforms.

6. **Cross-Platform:** Code must work on Android, iOS, Windows, macOS, Linux.

## Session End Protocol

**MANDATORY: Always end each session by:**
1. Updating `CHANGELOG.md` with all changes made
2. Updating `LAST_SESSION.md` with current state and context
3. Updating `PORTING_PROGRESS.md` checkboxes
4. Logging changes/decisions in DevilMCP
5. Running tests if significant changes were made
6. Committing changes if requested by user

## Memory Persistence Files

- **CHANGELOG.md**: Comprehensive change history (append-only)
- **LAST_SESSION.md**: Current state, quick context (overwrite each session)
- **PORTING_PROGRESS.md**: File-by-file tracking (update checkboxes)
- **DevilMCP Database**: Decision and change log (query frequently)
- **All four are critical** for maintaining context across sessions

## Additional Notes

- Prefer delegation over doing everything yourself
- Always invoke technical skills before working on detailed implementations
- Verify assumptions with the user when unclear
- Document architectural decisions in DevilMCP
- Keep the user informed of progress
- Ask for clarification rather than guessing requirements
- Use Quadrumvirate to maximize session lifespan (target: <5k tokens per file)
- ALWAYS USE DEVILMCP, AND FOLLOW THE FULL QUADRUMVIRATE WORKFLOW (Gemini, Cursor, And Copilot CLIs)