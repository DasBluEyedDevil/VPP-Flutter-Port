#!/bin/bash

# Cursor CLI Wrapper Script - Developer Subagent #1
# This script provides a convenient interface to invoke Cursor CLI
# for UI/Flutter widgets and complex reasoning tasks

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default settings
MODEL="composer-1"  # Cursor's best implementation model (requires premium tokens)
PROGRAMMATIC=true
FORCE=true
OUTPUT_FORMAT="text"
USE_WSL=true  # Default to WSL since cursor-agent is installed there
WSL_USER="devil"
WSL_PATH="/mnt/c/Users/dasbl/AndroidStudioProjects/VPP_Flutter_Port"  # Updated for Flutter project
PROMPT_FILE=""  # Optional: read prompt from file

# Function to display usage
usage() {
    cat << EOF
${GREEN}Cursor CLI Wrapper - Developer #1 (UI/Flutter/Complex Reasoning)${NC}

${BLUE}USAGE:${NC}
    $0 [OPTIONS] "<prompt>"

${BLUE}OPTIONS:${NC}
    -m, --model MODEL          Set the model (default: composer-1)
                              Options: composer-1, sonnet-4.5, sonnet-4.5-thinking, opus-4.1
    -i, --interactive          Interactive mode (not programmatic)
    --no-force                Disable force mode (require approval for operations)
    -o, --output FORMAT       Output format (default: text, options: json, markdown)
    -f, --prompt-file FILE    Read prompt from file (avoids bash escaping issues)
    --wsl                     Use WSL for execution
    --wsl-user USER           WSL user (default: devil)
    --wsl-path PATH           WSL project path (required if --wsl is used)
    -h, --help                Display this help message

${BLUE}EXAMPLES:${NC}
    ${YELLOW}# Standard Flutter widget implementation${NC}
    $0 "IMPLEMENTATION TASK: Create ConnectionStatusBanner widget..."

    ${YELLOW}# Complex algorithm (use thinking model)${NC}
    $0 -m sonnet-4.5-thinking "Optimize rep counting algorithm from O(n²) to O(n log n)"

    ${YELLOW}# Maximum capability for hardest tasks${NC}
    $0 -m opus-4.1 "Implement complex BLE state machine with edge case handling"

    ${YELLOW}# Interactive mode for visual validation${NC}
    $0 -i "Review and take screenshots of the new workout UI"

    ${YELLOW}# Use prompt file (recommended for complex prompts with code blocks)${NC}
    $0 -f /tmp/task.txt

${BLUE}ROLE IN QUADRUMVIRATE:${NC}
    Cursor is "Developer #1" - UI, Flutter widgets, and complex reasoning specialist
    - Flutter UI/widget implementation
    - Complex algorithmic problems (using Thinking models)
    - Interactive debugging
    - Visual validation with screenshots
    - Cross-checks Copilot's work

${BLUE}MODEL SELECTION GUIDE:${NC}
    ${CYAN}composer-1${NC}           Standard implementation, UI components, bug fixes (default)
    ${CYAN}sonnet-4.5${NC}           Alternative standard implementation
    ${CYAN}sonnet-4.5-thinking${NC}  Complex algorithms, difficult architectural decisions
    ${CYAN}opus-4.1${NC}             Maximum capability for extremely complex tasks

${BLUE}TASK TEMPLATE:${NC}
    FLUTTER PORTING TASK:

    **Objective**: Port [Kotlin file] to Flutter/Dart

    **Source File**: [path to .kt file]
    **Target File**: [path to .dart file]

    **Kotlin Code**:
    [paste Gemini's analysis]

    **Requirements**:
    - Direct 1:1 port to Flutter/Dart
    - Use Riverpod for state
    - Follow Material 3 guidelines
    - Preserve all functionality

    **After Completion**:
    1. Run flutter analyze
    2. Run tests
    3. Update PORTING_PROGRESS.md
    4. Report changes

${BLUE}CROSS-CHECK TEMPLATE:${NC}
    CODE REVIEW TASK:

    Copilot has ported [feature].

    **Files Changed**: [list]
    **Changes Summary**: [summary]

    **Review For**:
    1. Logic errors
    2. UI/visual concerns
    3. Edge cases
    4. Code quality

    Take screenshots if UI, run tests, report findings.

EOF
    exit 1
}

# Parse arguments
PROMPT=""
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--model)
            MODEL="$2"
            shift 2
            ;;
        -i|--interactive)
            PROGRAMMATIC=false
            shift
            ;;
        --no-force)
            FORCE=false
            shift
            ;;
        -o|--output)
            OUTPUT_FORMAT="$2"
            shift 2
            ;;
        -f|--prompt-file)
            PROMPT_FILE="$2"
            shift 2
            ;;
        --wsl)
            USE_WSL=true
            shift
            ;;
        --wsl-user)
            WSL_USER="$2"
            shift 2
            ;;
        --wsl-path)
            WSL_PATH="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            PROMPT="$1"
            shift
            ;;
    esac
done

# Read prompt from file if specified
if [ -n "$PROMPT_FILE" ]; then
    if [ ! -f "$PROMPT_FILE" ]; then
        echo -e "${RED}Error: Prompt file not found: $PROMPT_FILE${NC}"
        exit 1
    fi
    PROMPT=$(cat "$PROMPT_FILE")
fi

# Validate prompt
if [ -z "$PROMPT" ]; then
    echo -e "${RED}Error: Prompt is required (provide directly or via --prompt-file)${NC}"
    usage
fi

# Validate WSL settings if WSL is enabled
if [ "$USE_WSL" = true ] && [ -z "$WSL_PATH" ]; then
    echo -e "${RED}Error: --wsl-path is required when using --wsl${NC}"
    exit 1
fi

# Build the cursor-agent command arguments
CURSOR_ARGS="--force --model $MODEL --output-format $OUTPUT_FORMAT"

# Build the full WSL command
if [ "$USE_WSL" = true ]; then
    # WSL execution mode - call cursor-agent in WSL
    TEMP_PROMPT_FILE="/tmp/cursor-prompt-$$.txt"

    # Base64 encode to avoid ALL escaping issues
    PROMPT_B64=$(printf '%s' "$PROMPT" | base64 -w 0)
    wsl.exe bash -c "echo '$PROMPT_B64' | base64 -d > $TEMP_PROMPT_FILE"

    # Build WSL command
    WSL_CMD="cd '$WSL_PATH' && sudo -u $WSL_USER /home/$WSL_USER/.local/bin/cursor-agent $CURSOR_ARGS -f $TEMP_PROMPT_FILE"
else
    echo -e "${RED}Error: cursor-agent is only available in WSL. Use --wsl flag.${NC}"
    exit 1
fi

# Execute
echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   Cursor CLI - Developer #1 (Coding...)   ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Model:${NC} $MODEL"
echo -e "${BLUE}Programmatic:${NC} $PROGRAMMATIC"
echo -e "${BLUE}Force Mode:${NC} $FORCE"
echo -e "${BLUE}Output Format:${NC} $OUTPUT_FORMAT"
if [ "$USE_WSL" = true ]; then
    echo -e "${BLUE}WSL Execution:${NC} Yes (user: $WSL_USER, path: $WSL_PATH)"
fi
echo ""
echo -e "${YELLOW}Task Prompt:${NC}"
echo "$PROMPT"
echo ""
echo -e "${CYAN}════════════════════════════════════════════${NC}"
echo ""

# Create log file
LOG_FILE="/tmp/cursor-agent-$(date +%s).log"

# Cleanup function
cleanup() {
  echo -e "${YELLOW}Cleaning up orphaned cursor-agent processes...${NC}"
  wsl.exe bash -c "pkill -f 'cursor-agent.*worker-server' 2>/dev/null || true"
  rm -f "$LOG_FILE" 2>/dev/null || true
  if [ -n "$TEMP_PROMPT_FILE" ]; then
    wsl.exe bash -c "rm -f $TEMP_PROMPT_FILE 2>/dev/null || true"
  fi
}

# Set trap to cleanup on exit
trap cleanup EXIT INT TERM

# Execute cursor-agent via WSL in background
wsl.exe bash -c "$WSL_CMD" > "$LOG_FILE" 2>&1 &
CURSOR_PID=$!

echo -e "${BLUE}Cursor Agent PID:${NC} $CURSOR_PID"
echo -e "${BLUE}Log file:${NC} $LOG_FILE"
echo -e "${YELLOW}Monitoring for completion...${NC}"
echo ""

# Monitor for success
TIMEOUT=300  # 5 minutes
ELAPSED=0
SUCCESS_DETECTED=false

while kill -0 $CURSOR_PID 2>/dev/null; do
  if grep -qiE "success|completed|done|implementation complete|changes made" "$LOG_FILE" 2>/dev/null; then
    echo -e "${GREEN}Success detected in logs, allowing graceful completion...${NC}"
    SUCCESS_DETECTED=true
    sleep 5
    kill $CURSOR_PID 2>/dev/null || true
    break
  fi

  if [ $ELAPSED -ge $TIMEOUT ]; then
    echo -e "${YELLOW}Timeout reached ($TIMEOUT seconds), terminating...${NC}"
    kill -TERM $CURSOR_PID 2>/dev/null || true
    sleep 2
    kill -KILL $CURSOR_PID 2>/dev/null || true
    break
  fi

  sleep 2
  ELAPSED=$((ELAPSED + 2))

  if [ $((ELAPSED % 30)) -eq 0 ]; then
    echo -e "${BLUE}Still running... (${ELAPSED}s elapsed)${NC}"
  fi
done

# Wait for process to finish
wait $CURSOR_PID 2>/dev/null || true
EXIT_CODE=$?

echo ""
echo -e "${CYAN}════════════════════════════════════════════${NC}"
echo -e "${CYAN}Cursor Agent execution complete${NC}"
echo -e "${CYAN}════════════════════════════════════════════${NC}"
echo ""
echo "=== OUTPUT ==="
cat "$LOG_FILE"
echo "=== END OUTPUT ==="
echo ""

if [ "$SUCCESS_DETECTED" = true ] || [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✓ Cursor implementation complete${NC}"
else
    echo -e "${RED}✗ Cursor implementation failed or timed out (exit code: $EXIT_CODE)${NC}"
fi
echo -e "${CYAN}════════════════════════════════════════════${NC}"

exit $EXIT_CODE
