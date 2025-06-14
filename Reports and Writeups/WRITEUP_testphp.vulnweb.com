This website was "http://testhtml5.vulnweb.com". This website is designed with intentional vulnerabilities,
and gives universal permission to hack. It is made to be exploited.

The vulnerability scanner found 16 issues, many of which go together (8 of them are XSS indicators). It found
vulnerabilities such as SQL injections (error based), security misconfigurations, missing security headers, cross
site scripting with several payloads, sever banners, and "powered by" banners.

Finding 1: Error based SQL injection (high). This finding is crucial, since the scanner was able to create an error in
the search query, and reveal the type of SQL it is using:

Error: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''''''' at line 1

This reveals that MySQL is being used, which can allow a penetration tester to tailor their attack vector towards
MySQL. This can lead to database leakage.

Finding 2: Security Misconfiguration (high). The scanner found that directory listing for the "admin/" directory is
enabled, which can expose sensitive files. When putting "http://testphp.vulnweb.com/admin/" into the search bar, it
does, in fact, reveal senstive files. A file called "create.sql" can be downloaded by anyone, exposing sensitive 
data in a real situation. This in addition to the first finding can be catastrophic,

Finding 3: Security Header Missing (medium). This finding states that the site may be vulnerable to Clickjacking.

Findings 4-11: Reflected XSS (medium). XSS allows a third party (me in this case) to execute arbitrary code in the 
user's browser, which can expose sensitive information or grant sensitive privileges. In this case, it allows 
the user to run arbitrary code in the search query area. After testing manually, XSS does exist in the search query.
If this was something the developers wanted to fix, they should sanatize the input from the seach bar.

Finding 12: Security Misconfiguration -- Potentially sensitive file/directory login.php (medium). This is somewhat
of a vulnerability, since a login button does not explicitly appear on the main page. However, the login area
has an XSS risk as well, as when I tested it manually, I could inject code that was ran when loaded.

Finding 13: Security Header Missing (low). A content security policy header wasn't found, increasing XSS risk. This
is a good find, since XSS is something this website seems to struggle with.

Finding 14: Connectivity. The site is reachable

Finding 15: Information Disclosure. The server banner nginx/1.19.0 is disclosed.

Finding 16: Information Disclosure. The X powered by header PHP/5.6.40-38+ubuntu20.04.1+deb.sury.org+1 is disclosed.

This is an extremely unsecure website.