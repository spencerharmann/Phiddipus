
--------------------------------------------------
Starting Web Vulnerability Scan for: http://testphp.vulnweb.com
Rate Limit Delay: 0.1 seconds per request
--------------------------------------------------


[+] Running Information Gathering for: http://testphp.vulnweb.com

[+] Running XSS Scan for: http://testphp.vulnweb.com

[+] Running SQL Injection Scan for: http://testphp.vulnweb.com

[+] Running Security Misconfiguration Scan for: http://testphp.vulnweb.com

Scan finished.

[!!!!] Found 16 potential issues or information disclosures. [!!!!]

=== Scan Report ===

=== Finding 1 ===
Type: SQL Injection (Error-Based - MySQL)
Severity: High
Description: Potential SQL Injection detected in POST parameter 'searchFor'. Detected MySQL error.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: '''
Error pattern: 'SQL syntax.*MySQL' found.
==============================

=== Finding 2 ===
Type: Security Misconfiguration
Severity: High
Description: Directory listing enabled for: admin/. This can expose sensitive files.
URL: http://testphp.vulnweb.com/admin/
Evidence:
HTTP Status: 200
Content: Directory listing detected.
==============================

=== Finding 3 ===
Type: Security Header Missing
Severity: Medium
Description: X-Frame-Options header not found. Site may be vulnerable to Clickjacking.
URL: http://testphp.vulnweb.com
Evidence:
Missing X-Frame-Options header.
==============================

=== Finding 4 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<script>alert('XSS')</script>' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: <script>alert('XSS')</script>
Raw reflection detected.
==============================

=== Finding 5 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<body onload=alert('XSS')>' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: <body onload=alert('XSS')>
Raw reflection detected.
==============================

=== Finding 6 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<img src=x onerror=alert('XSS') style=display:none>' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: <img src=x onerror=alert('XSS') style=display:none>
Raw reflection detected.
==============================

=== Finding 7 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<svg onload=alert('XSS')>' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: <svg onload=alert('XSS')>
Raw reflection detected.
==============================

=== Finding 8 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '';alert(1)//' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: ';alert(1)//
Raw reflection detected.
==============================

=== Finding 9 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '<iframe srcdoc="<script>alert('XSS')</script>">' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: <iframe srcdoc="<script>alert('XSS')</script>">
Raw reflection detected.
==============================

=== Finding 10 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload ''><img src=x onerror=alert('XSS')>' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: '><img src=x onerror=alert('XSS')>
Raw reflection detected.
==============================

=== Finding 11 ===
Type: Reflected XSS (POST - Possible)
Severity: Medium
Description: XSS payload '"><script>alert('XSS')</script>' reflected in response for POST parameter 'searchFor', but context uncertain. Manual review recommended.
URL: http://testphp.vulnweb.com/search.php?test=query
Evidence:
Form Action: http://testphp.vulnweb.com/search.php?test=query
Parameter: searchFor
Payload: "><script>alert('XSS')</script>
Raw reflection detected.
==============================

=== Finding 12 ===
Type: Security Misconfiguration
Severity: Medium
Description: Potentially sensitive file/directory found: login.php. Review for sensitive information.
URL: http://testphp.vulnweb.com/login.php
Evidence:
HTTP Status: 200
First 200 chars: <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html><!-- InstanceBegin template="/Templates/main_dynamic_template.dwt.php" codeOutsideHTMLIsLoc...
==============================

=== Finding 13 ===
Type: Security Header Missing
Severity: Low
Description: Content-Security-Policy (CSP) header not found. This can increase XSS risk.
URL: http://testphp.vulnweb.com
Evidence:
Missing CSP header.
==============================

=== Finding 14 ===
Type: Connectivity
Severity: Informational
Description: Target URL is reachable and returned HTTP 200 OK.
URL: http://testphp.vulnweb.com
Evidence:
HTTP Status: 200
==============================

=== Finding 15 ===
Type: Information Disclosure
Severity: Informational
Description: Server banner disclosed: nginx/1.19.0
URL: http://testphp.vulnweb.com
Evidence:
Header: Server: nginx/1.19.0
==============================

=== Finding 16 ===
Type: Information Disclosure
Severity: Informational
Description: X-Powered-By header disclosed: PHP/5.6.40-38+ubuntu20.04.1+deb.sury.org+1
URL: http://testphp.vulnweb.com
Evidence:
Header: X-Powered-By: PHP/5.6.40-38+ubuntu20.04.1+deb.sury.org+1
==============================
=== End Report ===
