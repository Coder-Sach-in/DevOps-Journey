#!/bin/bash

# ====================================================================
# DAY 2: IP ADDRESSING & SUBNETTING MECHANICS LAB
# ====================================================================

# 1. See your machine's IP and subnet (Verify active interface card allocations)
ip addr show

# 2. See your local routing table (Check kernel ip forwarding paths)
ip route show

# 3. Find your default gateway (Extract your router's IP using a grep pipeline)
ip route | grep default

# 4. Check which subnet you're on
# [Note: Observe the CIDR suffix like /24 or /16 inside your 'ip addr show' output]

# 5. Install ipcalc engine for binary subnet calculations (Ubuntu/Debian based)
sudo apt update && sudo apt install -y ipcalc

# 6. Calculate subnet info for Class C /24 block
ipcalc 192.168.1.0/24

# 7. Calculate subnet info for a small /28 micro-block
ipcalc 10.0.0.0/28

# 8. See how packets route to Google (Analyze routing hops and network latency points)
traceroute google.com

