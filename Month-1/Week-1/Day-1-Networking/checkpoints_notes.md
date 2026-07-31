# 🧠 Day 1: Theoretical Checkpoints & Concepts

### Q1. What are the 7 OSI layers and one example for each?
1. **Physical Layer:** Cables, Fiber Optics, Hubs.
2. **Data Link Layer:** MAC Addresses, Network Switches.
3. **Network Layer:** IP Addressing, Routers (Ping/ICMP operates here).
4. **Transport Layer:** TCP (reliable) and UDP (fast) protocols.
5. **Session Layer:** Connection management, NetBIOS, RPC.
6. **Presentation Layer:** Encryption/Decryption, SSL/TLS, Data formats.
7. **Application Layer:** What user interacts with (HTTP, HTTPS, SSH, DNS).

### Q2. What is the difference between an IP address and a port?
* **IP Address:** The logical address of the server/machine on a network (like a building's street address).
* **Port:** The logical entry point for a specific service on that machine (like a room number inside that building, e.g., Web on 80/443, SSH on 22).

### Q3. What is the 3-way TCP handshake and why does it exist?
* **Process:** Client sends `SYN` -> Server responds with `SYN-ACK` -> Client sends `ACK`.
* **Why it exists:** It creates a reliable connection parameters channel before actual data transmission begins, ensuring no data loss.

### Q4. Why does DNS exist? What would break without it?
* **Why it exists:** It acts as the internet's phonebook, translating human-readable names (`google.com`) into computer-readable IPs (`142.250.183.46`).
* **What breaks:** The entire web architecture breaks for end-users, as no one would be able to access web services unless they memorized the exact numeric IP strings.

### Q5. When would you choose UDP over TCP?
* **UDP Selection:** Chosen when extreme transmission speed is mandatory and minor packet drops do not affect the outcome.
* **Examples:** Live video streaming, real-time gaming, VoIP calls, and raw DNS lookups.

### Q6. What port does SSH use? HTTPS?
* **SSH:** Port `22` (Secure Shell Remote Administration).
* **HTTPS:** Port `443` (Secure Hypertext Web Traffic).

