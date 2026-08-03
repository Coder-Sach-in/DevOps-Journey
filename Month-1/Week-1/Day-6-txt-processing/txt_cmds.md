# 🧠 Day 6: Advanced Text Processing Checkpoints

### Q1. What is the difference between `grep -E` and `grep -F`?
* **`grep -E` (Extended Regex):** Treats the pattern as an extended regular expression. It allows you to use powerful operators like `|` (OR), `+` (one or more), and `?` (optional) directly without backslash escapes.
  * *Command:* `grep -E "ERROR|FATAL" app.log`
* **`grep -F` (Fixed Strings):** Disables the regular expression engine entirely. It treats characters as exact literal strings (e.g., matching a dot `.` as a literal dot, not a regex wildcard). This makes search operations **extremely fast**.
  * *Command:* `grep -F "192.168.1.1" access.log`

### Q2. Change `DB_HOST=localhost` to `DB_HOST=10.0.0.5` in a `.env` file without opening it (including backup).
* **Command:**
  ```bash
  sed -i.bak 's/DB_HOST=localhost/DB_HOST=10.0.0.5/g' .env
  ```
* **Explanation:** The `-i.bak` flag edits the `.env` file directly in-place while instantly creating a safety copy named `.env.bak` before any transformation occurs.

### Q3. Write an `awk` command that prints the average response size (`$10`) for only `200` status (`$9`) requests.
* **Command:**
  ```bash
  awk '\$9 == 200 { sum += \$10; count++ } END { if (count > 0) printf "Average Size: %.2f bytes\n", sum/count; else print "No 200 OK entries found." }' access.log
  ```
* **Explanation:** `$9 == 200` acts as a conditional gate. For every matching line, it aggregates column 10 to a running `sum` and increments a record counter. The `END` block triggers at the end of file parsing to output the computed dynamic average.

### Q4. Pipeline to find brute-forcing SSH IPs with more than 5 failed attempts in `/var/log/auth.log`.
* **Command:**
  ```bash
  grep "Failed password" /var/log/auth.log | awk '{ print \$(NF-3) }' | sort | uniq -c | sort -rn | awk '\$1 > 5 { print "Attacker IP: " \$2 " (Failures: " \$1 ")" }'
  ```
* **Explanation:** 
  1. `grep` captures all invalid password actions.
  2. `awk '{ print $(NF-3) }'` extracts the IP address position dynamically relative to the end of the text line.
  3. `sort | uniq -c | sort -rn` groups, counts frequencies, and listings by highest count.
  4. The final `awk '$1 > 5'` strips away noisy entries, exposing only aggressive hosts.

### Q5. What does `grep -C 3 "FATAL" app.log` show and when is it useful?
* **What it shows:** It displays the exact line containing the keyword `"FATAL"`, along with **3 lines of historical logs before (Above)** it and **3 lines of log history after (Below)** it.
* **When it is useful:** It is critical for **root-cause analysis during system debugging**. A standalone error message is often useless; reading the immediate surrounding infrastructure behavior states lets an engineer identify exactly what event triggered the system failure.

