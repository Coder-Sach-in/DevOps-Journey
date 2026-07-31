#!/bin/bash

# ====================================================================
# DAY 5: BASH SCRIPTING & AUTOMATION FUNDAMENTALS LAB
# ====================================================================

# --- LAB WORK 1: Setup Hello World Script ---
# [Action Required: Run 'nano hello.sh' and add the following lines]
# #!/bin/bash
# echo "Hello, DevOps Journey!"

# --- LAB WORK 2: Port Checker Script ---
# [Action Required: Run 'nano port-check.sh' and add the logic below]
# #!/bin/bash
# set -euo pipefail
# PORT="${1:-80}" # Accepts port as 1st argument, defaults to 80
# if ss -tlnp | grep -q ":$PORT "; then
#     echo "Port $PORT is ACTIVE and listening."
# else
#     echo "Port $PORT is FREE."
# fi

# --- LAB WORK 3: Server Health Check Script ---
# [Action Required: Run 'nano health-check.sh' and paste the Part 8 logic]

# 4. Make all newly created shell scripts executable in one shot [1]
chmod +x *.sh

# 5. Test Successful Exit Codes (Should return 0)
ls /tmp
echo "Exit code: $?"

# 6. Test Failed Exit Codes (Should return non-zero, e.g., 2)
ls /nonexistent || true # Added || true to prevent shell lock if run under strict mode
echo "Exit code: $?"

# 7. Install ShellCheck for script static analysis linting
sudo apt update && sudo apt install -y shellcheck

# 8. Run ShellCheck to debug and validate script standard practices
# [Note: Fix all warnings printed by the linter engine]
# shellcheck health-check.sh

