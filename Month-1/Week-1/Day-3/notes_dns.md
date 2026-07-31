# 🧠 Day 3: DNS, HTTP/HTTPS, & TLS Checkpoints

### Q1. What is a CNAME record and when would you use one?
* **Canonical Name (CNAME) Record:** It acts as an alias that maps one domain name to another domain name instead of a numeric IP address.
* **When to use:** You use it when you want multiple subdomains (like `://myapp.com` or `://myapp.com`) to point to a central root address or an external service provider's domain (like a cloud load balancer or AWS CloudFront distribution). If the backend IP changes, you only update the main target record.

### Q2. A user reports your site shows "Connection Not Secure." What's the likely cause and how do you fix it?
* **Likely Causes:** 
  1. The server's SSL/TLS certificate has **expired**.
  2. The certificate domain name does not match the actual website URL (Host Mismatch).
  3. The certificate is self-signed or issued by an untrusted Certificate Authority (CA).
* **How to fix:** Generate a valid, trusted SSL/TLS certificate from an official provider like Let's Encrypt (using Certbot) or AWS ACM, configure it properly in your Nginx/Apache configuration, and ensure automated renewal cron jobs are active.

### Q3. What's the difference between a 401 and 403 status code?
* **401 Unauthorized:** The user is **not authenticated** (the server does not know who you are). You must provide valid login credentials (username/password or token) to access the resource.
* **403 Forbidden:** The server knows exactly who you are, but you **do not have permissions** (unauthorized access control level) to view the resource. For example, a normal customer trying to access an `/admin` panel. Logging in again will not help here.

### Q4. What does TTL control in DNS and why would you lower it before a migration?
* **TTL (Time To Live):** It controls the exact duration (in seconds) that intermediate routers and DNS resolvers can cache your DNS record before querying the authoritative Name Server again.
* **Why lower it before migration:** If your TTL is set to 24 hours, resolvers will take up to a full day to recognize your new server IP after a migration, causing massive downtime. Lowering the TTL (e.g., to 300 seconds) a few days *before* migration ensures that traffic routes to the new server instantly when you flip the switch.

### Q5. You need to verify domain ownership for AWS. Which DNS record type do you add?
* **Answer:** You add a **TXT (Text) Record** or a specific **CNAME Record**. 
* AWS (and other providers like Google/GitHub) will give you a unique tracking string. Pasting this token value into your DNS settings proves to AWS that you own and control the domain.

### Q6. What does a 502 Bad Gateway tell you about where the failure is?
* **Answer:** It tells you that the network edge proxy server (like Nginx or an AWS ALB) is healthy, but the **backend application server** (like a Python/Node.js app or a PHP-FPM process) is down, crashed, or not responding to network requests. The proxy server failed to get a valid response from the upstream server.

