#!/bin/bash

# ====================================================================
# DAY 1: CORE NETWORKING & DIAGNOSTICS LAB
# ====================================================================

# 1. Trace the DNS resolution journey (Map domain name to IP address)
nslookup google.com

# 2. See each router hop your packet takes to reach Google (Track network path delays)
traceroute google.com

# 3. See all active network connections on your machine (List listening TCP/UDP ports)
ss -tuln

# 4. Check your own IP address (Verify local network interface allocations)
ip addr show

# 5. See your routing table (Understand how your OS decides network gateways)
ip route show

# 6. Test raw connectivity (Run ICMP Layer 3 verification ping with 4 packets)
ping -c 4 google.com

# 7. Scan which ports are open on your own machine (Internal security port auditing)
nmap localhost

