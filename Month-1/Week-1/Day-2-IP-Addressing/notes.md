# 🧠 Day 2: IP Addressing & Subnetting Checkpoints

### Q1. What is the difference between a public and private IP address?
* **Private IP Address:** Used exclusively inside local area networks (LAN) like your home Wi-Fi or a corporate data center. These are free, non-routable on the public internet, and isolated from external threats (e.g., `192.168.x.x`, `10.x.x.x`).
* **Public IP Address:** A unique globally routable address assigned by your Internet Service Provider (ISP). It is visible to the entire world and allows servers to send/receive data across the public internet.

### Q2. What does /24 mean in 192.168.1.0/24? How many usable hosts?
* **Meaning of /24:** It represents the **Subnet Mask in CIDR notation**. It means the first 24 bits out of 32 bits are locked for the **Network ID**, leaving 8 bits for host addresses (`255.255.255.0`).
* **Total Hosts calculation:** $2^8 = 256$ total addresses.
* **Usable Hosts:** **254**. (Formula: $2^{\text{host bits}} - 2$). We subtract 2 because the first IP (`192.168.1.0`) is reserved for the **Network Address**, and the last IP (`192.168.1.255`) is reserved for the **Broadcast Address**.

### Q3. You're given 10.0.0.0/28 — what is the usable host range?
* **CIDR Breakdown:** `/28` means 28 bits are for the network, leaving 4 bits for hosts ($32 - 28 = 4$).
* **Total Addresses:** $2^4 = 16$.
* **Network IP:** `10.0.0.0`
* **Broadcast IP:** `10.0.0.15`
* **Usable Host Range:** **`10.0.0.1` to `10.0.0.14`** (Total 14 usable hosts).

### Q4. Why does AWS separate web servers and databases into different subnets?
* **Security Hardening (Isolation):** Web servers need to face the public internet to handle user requests, so they are placed in a **Public Subnet** (with an attached Internet Gateway). 
* Databases contain highly sensitive company data and should never be exposed to internet hackers. They are isolated inside a **Private Subnet**, allowing only the web servers to talk to them internally, significantly lowering the attack surface.

### Q5. Your home network is 192.168.0.0/24. Can it have 300 devices? Why or why not?
* **Answer:** **No, it cannot have 300 devices simultaneously.**
* **Reason:** As calculated in Q2, a `/24` subnet can only allocate a maximum of 254 usable IP addresses. If you connect 300 devices, 46 devices will experience an **IP address exhaustion failure** (they won't get an IP from the DHCP server and cannot connect to the network) unless the network architecture is upgraded to a `/23` block.

