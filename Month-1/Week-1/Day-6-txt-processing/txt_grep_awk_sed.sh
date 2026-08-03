#!/bin/bash

# ====================================================================
# DAY 6: ENTERPRISE LOG PARSING & TEXT PROCESSING (GREP, SED, AWK)
# ====================================================================

# --- LAB SETUP: Create a sample log file to practice on ---
cat > /tmp/sample.log << 'EOF'
192.168.1.10 - frank [10/Jul/2025:13:55:36] "GET /index.html HTTP/1.1" 200 2326
192.168.1.20 - alice [10/Jul/2025:13:55:37] "POST /api/login HTTP/1.1" 401 512
192.168.1.10 - frank [10/Jul/2025:13:55:38] "GET /dashboard HTTP/1.1" 200 8192
10.0.0.5 - - [10/Jul/2025:13:55:39] "GET /admin HTTP/1.1" 403 256
192.168.1.30 - bob [10/Jul/2025:13:55:40] "GET /notfound HTTP/1.1" 404 128
192.168.1.10 - frank [10/Jul/2025:13:55:41] "DELETE /api/user HTTP/1.1" 500 64
10.0.0.5 - - [10/Jul/2025:13:55:42] "POST /api/login HTTP/1.1" 401 512
192.168.1.20 - alice [10/Jul/2025:13:55:43] "GET /index.html HTTP/1.1" 200 2326
EOF

# --- LAB PRACTICES ---

# 1. Find all lines with status code 401 (Isolate unauthorized hits)
grep " 401 " /tmp/sample.log

# 2. Count how many 200 OK responses exist (Extract metrics number)
grep -c " 200 " /tmp/sample.log

# 3. Show only the IP addresses (Extract first column via default whitespace delimiter)
awk '{ print $1 }' /tmp/sample.log

# 4. Show lines where status >= 400 (Print IP, URL, and Status Code)
awk '$9 >= 400 { print $1, $7, $9 }' /tmp/sample.log

# 5. Replace all instances of HTTP/1.1 with HTTP/2.0 globally
sed 's/HTTP\/1\.1/HTTP\/2.0/g' /tmp/sample.log

# 6. Delete all comment (#) and empty lines from a production configuration file
sed '/^#/d; /^$/d' /etc/nginx/nginx.conf 2>/dev/null || echo "nginx not installed yet"

# 7. Count requests per IP address using the classic sort pipeline
awk '{ print $1 }' /tmp/sample.log | sort | uniq -c | sort -rn

# 8. Build full pipeline to find top IP addresses responsible for errors (>= 400)
awk '$9 >= 400 { print $1 }' /tmp/sample.log | sort | uniq -c | sort -rn

