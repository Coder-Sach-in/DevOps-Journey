# 🧠 Day 7: Linux Automation & Cron Jobs Checkpoints

### Q1. Decode these cron expressions in plain English: `*/15 * * * *`, `0 2 * * 0`, `0 8-18 * * 1-5`, `0 0 1 * *`
* **`*/15 * * * *`** ➔ Runs **every 15 minutes** (e.g., 12:00, 12:15, 12:30...).
* **`0 2 * * 0`** ➔ Runs **every Sunday at exact 2:00 AM**.
* **`0 8-18 * * 1-5`** ➔ Runs **every hour between 8:00 AM and 6:00 PM (18:00), from Monday to Friday**.
* **`0 0 1 * *`** ➔ Runs at **midnight (12:00 AM) on the 1st day of every month**.

### Q2. Your cron job runs fine manually but silently does nothing when scheduled. What are the three most likely causes?
* **Answer:** The three most likely causes for a cron job to fail silently are:
  1. **Missing Absolute Paths**: Cron does not inherit your normal shell's path layout. Commands like `systemctl` will fail unless specified with full binary paths (e.g., `/usr/bin/systemctl`).
  2. **Minimal Environment Variables**: Cron executes scripts with a bare-minimum environment. Crucial shell variables like `PATH`, `HOME`, or `USER` are either altered or missing entirely unless explicitly hardcoded at the top of the crontab file.
  3. **Missing File/Script Permissions**: The underlying automated script might lack the mandatory execute flags (requires explicit application of `chmod +x`).

### Q3. What is a lock file and why does a backup cron job need one?
* **Lock File:** A temporary runtime token or reference file dropped onto the system (typically in `/var/lock/` or `/tmp/`) by an operating script to indicate that its workflow is actively running.
* **Why a Backup Needs It:** Heavy processes like cloud data backups or database compression utilities can sometimes run longer than their scheduled intervals. If a script takes 10 minutes to execute but is scheduled on a `*/5` (every 5 minutes) window, a second instance will spawn while the first is still active. A locking utility like **`flock`** prevents this overlap, stopping the redundant process instantly to protect the system from RAM/CPU exhaustion and sudden crashes.

### Q4. What is the difference between `>` and `>>` in cron output redirection and which should you use?
* **`>` (Overwrite)**: Truncates and wipes out the historical content inside the designated log file, replacing it entirely with the fresh stream of data from the latest run.
* **`>>` (Append)**: Preserves every line of existing historical telemetry data, cleanly attaching the latest run's output to the bottom of the target file.
* **Which to use:** In production setups, always use **`>>` (Append)** combined with standard error capturing (`2>&1`) to preserve logs for audit compliance and active failure diagnostics.

### Q5. Write a cron expression that runs a script at 11:45pm every Friday.
* **Answer:** 
  ```text
  45 23 * * 5 /usr/local/bin/my-script.sh
  ```
* **Explanation:** Calculated using the Right-to-Left interpretation: 5 (Friday) ➔ * (Every Month) ➔ * (Every Day) ➔ 23 (11:00 PM military format) ➔ 45 (45th minute of the hour).

### Q6. What does `Persistent=true` do in a systemd timer that cron cannot do?
* **Answer:** It acts as a fallback handler for server downtime periods. 
* **The Difference:** If a production machine crashes or goes offline during an active Cron schedule, Cron completely skips that task and waits until the next scheduled window. However, with `Persistent=true` enabled inside a systemd timer, systemd actively tracks the last execution timestamp. If it uncovers a missed run during standard boot cycles, it immediately fires the missed automated script to close the coverage gap.


