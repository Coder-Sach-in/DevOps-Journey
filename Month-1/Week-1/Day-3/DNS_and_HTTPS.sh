#!/bin/bash

# ====================================================================
# DAY 3: DNS DEEP DIVE, HTTP/HTTPS, & TLS SECURITY LAB
# ====================================================================

# 1. Look up standard IP (A record) for a domain
nslookup -type=A google.com

# 2. Look up Mail Exchange (MX) records for routing emails
nslookup -type=MX google.com

# 3. Look up Text (TXT) records (used for domain verification/security)
nslookup -type=TXT google.com

# 4. Look up Name Server (NS) records responsible for the domain zone
nslookup -type=NS google.com

# 5. Use dig for cleaner and highly detailed standard DNS query output
dig google.com

# 6. Query specific Mail Exchange (MX) records using dig
dig google.com MX

# 7. Query Text (TXT) validation records using dig
dig google.com TXT

# 8. Trace the entire DNS resolution chain from root servers step-by-step
dig +trace google.com

# 9. Extract SSL/TLS certificate validity dates, subject, and issuer info
echo | openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates -subject -issuer

# 10. Local DNS Overriding (Static mapping)
# [Action Required: Manually run 'sudo nano /etc/hosts' and append: 127.0.0.1 mytestsite.local]
# [Verification: Then run 'ping mytestsite.local' to check local loopback resolution]

# 11. Fetch only the HTTP response headers from a server (Metadata check)
curl -I https://google.com

# 12. Inspect the complete raw verbose HTTP/HTTPS request and response exchange
curl -v https://google.com 2>&1 | head -50

