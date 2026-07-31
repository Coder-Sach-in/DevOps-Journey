#!/bin/bash

# ====================================================================
# DAY 4: LINUX PROCESS MANAGEMENT, SYSTEMD, & PERMISSIONS LAB
# ====================================================================

# 1. View all currently running system processes (Filter top 20 lines)
ps aux | head -20

# 2. Find the exact Process ID (PID) of the secure shell daemon (sshd)
pgrep sshd

# 3. Check what services are actively listening on network ports (With process PIDs)
sudo ss -tlnp

# 4. Install Nginx web server engine (Debian/Ubuntu platforms)
sudo apt update && sudo apt install -y nginx

# 5. Verify the active systemd execution status of Nginx service
sudo systemctl status nginx

# 6. Enable Nginx service to boot up automatically on server restart
sudo systemctl enable nginx

# 7. View the last 20 service-specific logs managed by systemd journalctl
sudo journalctl -u nginx -n 20

# 8. Tail live incoming Nginx access logs in real-time
# [Note: Run this in a separate terminal panel to see live web requests]
# tail -f /var/log/nginx/access.log

# 9. Create a custom automated systemd system service file
# [Action Required: Execute 'sudo nano /etc/systemd/system/test-app.service']
# [Action Required: Paste the Part 4 systemd Service block from your theory notes]

# 10. Reload systemd manager configuration to recognize the new service unit
sudo systemctl daemon-reload

# 11. Inspect the status of your newly generated custom test application service
sudo systemctl status test-app

# 12. Workspace setup for testing Linux security permissions
mkdir -p ~/permtest
touch ~/permtest/script.sh
touch ~/permtest/config.env

# 13. Set permissions to 755 (Owner: Read/Write/Execute, Group/Others: Read/Execute)
chmod 755 ~/permtest/script.sh

# 14. Set permissions to 600 (Owner: Read/Write only, Group/Others: Zero Access)
chmod 600 ~/permtest/config.env

# 15. Verify and read the exact permission string output to audit changes
ls -la ~/permtest/

