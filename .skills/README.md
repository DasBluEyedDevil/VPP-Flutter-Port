# AI Quadrumvirate - Flutter Port Edition

Token-efficient orchestration system for porting VitruvianRedux (Kotlin) to VPP_Flutter_Port (Flutter/Dart).

## Core Philosophy

**Token Conservation Through Strategic Delegation**

Claude Code maximizes token lifespan by treating Cursor CLI and Copilot CLI as expendable developer subagents, and Gemini CLI as an unlimited-context code analyst.

## The Four Roles

### 1. Claude Code - The Orchestrator (You)
**Role**: Strategist, Architect, Decision-Maker, Coordinator

**Responsibilities**:
- Gather and clarify requirements
- Query Gemini for code analysis (both Kotlin source and Dart target)
- Create implementation specifications
- Delegate tasks to Cursor/Copilot
- Coordinate cross-checking
- Verify final results
- Use DevilMCP for all decision tracking

**Token Budget**: ~3-5k per file port (vs 15k+ old approach)

---

### 2. Gemini CLI - The Researcher (The Eyes)
**Role**: Unlimited-Context Code Analyst

**Responsibilities**:
- Analyze Kotlin source files (unlimited tokens!)
- Analyze Flutter/Dart target files
- Compare Kotlin vs Dart implementations
- Trace bugs across multiple files
- Review architectural patterns
- Provide porting guidance

**Token Budget**: Unlimited (1M+ context window) - use freely

**Wrapper**: `.skills/gemini.agent.wrapper.sh`

---

### 3. Cursor CLI - Engineer #1
**Role**: Flutter UI/Widgets, Complex Reasoning

**Responsibilities**:
- Implement Flutter UI widgets
- Port Jetpack Compose to Flutter
- Complex algorithmic problems (using Thinking models)
- Visual validation
- Cross-check Copilot's work

**Token Budget**: Expendable - use for all UI work

**Wrapper**: `.skills/cursor.agent.wrapper.sh`

---

### 4. Copilot CLI - Engineer #2
**Role**: Backend/Dart/BLE/GitHub Operations

**Responsibilities**:
- Port backend/BLE logic from Kotlin to Dart
- Port repositories and data layer
- Database operations (Room → Drift)
- GitHub operations (PRs, issues)
- Git operations
- Cross-check Cursor's work

**Token Budget**: Expendable - use for all backend/BLE work

**Wrapper**: `.skills/copilot.agent.wrapper.sh`

---

## Quick Start: Porting a File

### Step 1: Ask Gemini to Analyze Source
```bash
.skills/gemini.agent.wrapper.sh -d "@C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/" "
Analyze the Kotlin file: [path to .kt file]

Provide:
1. Complete code with explanations
2. Dependencies and imports
3. Key logic and algorithms
4. Edge cases and quirks
5. Integration with other files

Format output for easy Dart translation."
```

### Step 2: Delegate to Appropriate Engineer

**For UI/Widgets (Cursor):**
```bash
.skills/cursor.agent.wrapper.sh "FLUTTER PORTING TASK:

**Source File:** app/src/.../HomeScreen.kt
**Target File:** lib/presentation/screens/home_screen.dart

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

**Source File:** app/src/.../VitruvianBleManager.kt
**Target File:** lib/data/ble/vitruvian_ble_manager.dart

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

### Step 3: Cross-Check
```bash
# Copilot reviews Cursor's UI work
.skills/copilot.agent.wrapper.sh "CODE REVIEW:
Review Cursor's [file] implementation.
Check: logic, integration, tests, performance."

# Cursor reviews Copilot's backend work
.skills/cursor.agent.wrapper.sh "CODE REVIEW:
Review Copilot's [file] implementation.
Check: correctness, edge cases, tests."
```

### Step 4: Verify with Gemini
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
```

**Claude's Token Usage**: ~3k per file (80% savings!)

---

## Token Savings

| Task | Old Approach | Quadrumvirate | Savings |
|------|-------------|---------------|---------|
| File Port | 15k tokens | 3-5k tokens | **67-80%** |
| Bug Investigation | 28k tokens | 2k tokens | **93%** |
| Code Review | 28k tokens | 1k tokens | **96%** |

**Result**: 8-10x session lifespan, 40+ files per 200k token session (vs 5-7 in old approach)

---

## Success Criteria

You're using the Quadrumvirate correctly when:
1. ✅ Claude's token usage is <5k per file
2. ✅ Gemini is queried before implementation
3. ✅ Cursor/Copilot do all implementation work
4. ✅ Developers cross-check each other
5. ✅ Superpowers skills are used for structure
6. ✅ TodoWrite tracks progress
7. ✅ DevilMCP logs all decisions and changes
8. ✅ Final verification uses Gemini + minimal Claude reads

---

## Project Context: VPP_Flutter_Port

**Porting Task**: VitruvianRedux (Kotlin/Android) → VPP_Flutter_Port (Flutter/Dart)

**Source Project**: `C:\Users\dasbl\AndroidStudioProjects\VitruvianRedux`
- 71 Kotlin files
- Clean Architecture (domain/data/presentation)
- Jetpack Compose UI
- Nordic BLE Library
- Room database

**Target Project**: `C:\Users\dasbl\AndroidStudioProjects\VPP_Flutter_Port`
- Mirror Clean Architecture
- Flutter widgets
- flutter_blue_plus (BLE)
- Riverpod (state + DI)
- Drift (database)

**Technology Mappings**:
- ViewModel → StateNotifier
- StateFlow → StateNotifierProvider
- SharedFlow → StreamProvider
- Hilt → Riverpod DI
- Room → Drift
- Coroutines → async/await
- Flow → Stream

---

## Integration with Claude Code

This system works seamlessly with Claude Code's native features:

- **Superpowers Skills**: Use for structured workflows (brainstorming, TDD, systematic-debugging)
- **TodoWrite**: Track progress and coordinate multi-step tasks
- **DevilMCP**: Log all decisions, changes, and impacts
- **Task Tool**: Can still use for subagent delegation when appropriate
- **CLAUDE.md**: Session start protocol and token conservation rules

---

## Summary

**The Philosophy**:
- **Claude**: Conductor who never plays instruments directly
- **Gemini**: Unlimited knowledge base for both Kotlin and Dart, always consulted
- **Cursor/Copilot**: Expendable developers who do the porting work
- **DevilMCP**: Memory and decision tracking system
- **Result**: 80-90% token savings, 8-10x session lifespan

**Target**: <5k tokens per file, enabling 40+ files per 200k token session.

**Remember**: Your value is in orchestration and decision-making, not in reading files or writing code. Delegate everything except strategic thinking.
