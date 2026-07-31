# 🧠 Day 4: System Management & Permissions Checkpoints

### Q1. What is PID 1 and why is it special?
* **Answer:** PID 1 is the **`systemd`** process (or `init` on older Linux versions). It is the very first user-space process started by the Linux kernel during server boot.
* **Why it is special:** It acts as the direct parent or "ancestor" of every single process running on the operating system. If PID 1 dies, the kernel crashes instantly (Kernel Panic). It is also responsible for adopting orphaned processes and managing system initialization.

### Q2. What is the difference between SIGTERM and SIGKILL? When do you use each?
* **SIGTERM (Signal 15):** The **Graceful Termination** signal. It politely requests a process to stop. The process can catch this signal, save its current state, close active database connections, clean up temporary files, and exit cleanly. (Always use this first).
* **SIGKILL (Signal 9):** The **Forceful Kill** signal. It cannot be caught, ignored, or blocked by the process. The Linux kernel instantly rips the process out of memory. 
* **When to use:** Use `SIGKILL` only when a process becomes completely unresponsive (zombie or frozen state) and refuses to shut down after receiving a `SIGTERM`.

### Q3. A file has permissions 640. What can the owner, group, and others do?
* **Owner (6 = 4+2):** Can **Read** (4) and **Write** (2). Cannot execute.
* **Group (4):** Can **Read** (4) only. Cannot modify, cannot execute.
* **Others (0):** Have **Zero Access**. They cannot see, read, edit, or interact with the file at all.

### Q4. Why is `chmod 777` dangerous on a config file containing database credentials?
* **Security Threat:** `777` means **Global Unlimited Access** (Read, Write, and Execute for everyone on the planet). 
* Any malicious user, compromised low-level background service, or hacker script running on that machine can instantly read your database passwords, modify the configurations, inject corrupt data, or wipe out the production database entirely.

### Q5. What does `systemctl enable` do differently from `systemctl start`?
* **`systemctl start`:** This is an **immediate action**. It instantly spawns the process into runtime memory *right now*, but does not touch the system boot configuration. If the server restarts, the service will remain closed.
* **`systemctl enable`:** This is a **future persistent action**. It does not start the process right now. Instead, it hooks up symbolic links (`symlinks`) inside systemd directories so that the process triggers automatically whenever the machine boots up or restarts.

### Q6. Your app crashes on the server. Walk me through the exact steps to diagnose it.
1. **Check Service Status:** Run `sudo systemctl status my-app` to check if it's dead, see the uptime, and view the exit code error.
2. **Inspect Systemd Logs:** Execute `sudo journalctl -u my-app -n 50 --no-pager` to read the stdout/stderr crash traces of the application.
3. **Follow Real-time Logs:** Monitor live behaviors using `tail -f /var/log/my-app/error.log` while triggering test requests.
4. **Audit Resource Usage:** Run `top` or `htop` to ensure the process didn't crash due to Out-Of-Memory (OOM Killer) limits.
5. **Verify Ports:** Run `sudo ss -tlnp` to make sure another service isn't blocking the application's target listening port.

### Q7. What permission should an SSH private key have and why?
* **Permission:** **`600`** (`-rw-------`) or **`400`** (`-r--------`).
* **Why:** An SSH private key (`id_rsa`) is your supreme digital identity token. Linux security frameworks (and the OpenSSH client itself) are hardcoded to block connections and throw a *"Permissions are too open"* critical error if your private key is accessible by anyone other than the exact owner.

