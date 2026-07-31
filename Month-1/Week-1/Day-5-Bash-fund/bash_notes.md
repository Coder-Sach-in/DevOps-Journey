# 🧠 Day 5: Bash Scripting Core Checkpoints

### Q1. What does `set -euo pipefail` do and why put it in every script?
* **Answer:** This is the **Strict Mode** safety switch for enterprise Bash scripts. It combines three powerful behaviors:
  1. `-e` (Exit immediately): The script terminates instantly if any single command fails or returns a non-zero exit code.
  2. `-u` (Unset variables): Treats uninitialized or missing variables as an immediate critical error instead of silently passing a blank string.
  3. `-o pipefail` (Pipeline failure tracking): Ensures that a pipeline (e.g., `cmd1 | cmd2`) fails if *any* command inside the chain fails, not just the last one.
* **Why put it:** It prevents broken scripts from continuing to run blindly and causing unintended data destruction on production infrastructure.

### Q2. What is `$?` and when do you check it?
* **Answer:** `$?` is a special shell variable that holds the **Exit Status Code** of the most recently executed foreground command.
* **Range:** It ranges from `0` to `255`. A value of `0` indicates a complete, flawless success. Any number greater than 0 represents a specific error or structural failure.
* **When to check:** You check it immediately after running critical background tasks (like a remote file backup or disk backup utility) using an conditional `if` loop to verify if the step passed or failed before triggering subsequent processes.

### Q3. What is the difference between a local and global variable in a function?
* **Global Variable:** By default, every variable in Bash is global. Once declared inside or outside a function, it can be accessed, modified, or overwritten by any other line anywhere inside the script.
* **Local Variable:** Declared inside a function using the **`local`** keyword (e.g., `local my_var="value"`). It exists strictly within the boundaries of that specific function. Once the function finishes execution, the variable is permanently destroyed, avoiding variable naming collisions in large automated scripts.

### Q4. Your backup script runs but leaves temp files behind when it crashes. What bash feature fixes this?
* **Answer:** The **`trap`** command engine.
* **How it fixes:** The `trap` feature allows you to intercept internal Linux signals or events (like a script crash `ERR`, an intentional manual exit `EXIT`, or a forced interruption `SIGINT`). You can hook a cleanup function to it that triggers automatically to wipe out `/tmp/` staging files before the script shuts down.
* **Example:** `trap 'rm -rf /tmp/backup_staging_*' EXIT`

### Q5. Write a one-liner that checks if nginx is running and prints "UP" or "DOWN".
* **Answer:**
  ```bash
  systemctl is-active --quiet nginx && echo "UP" || echo "DOWN"
  ```
* **Explanation:** `systemctl is-active --quiet` checks the operational state of Nginx without printing anything to stdout. If it returns exit code `0` (active), the `&&` operator triggers to print "UP". If it fails, the logical `||` operator catches it and prints "DOWN".

