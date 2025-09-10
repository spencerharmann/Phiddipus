# 🕷️Phidippus
Phidippus is an asynchronous web vulnerability scanner written in python. It exposes common web vulnerabilities such as SQL injections, Cross-Site Scripting (XSS), security misconfigurations, sensitive file paths, and more. It also gathers information about the target like server banners and headers that can be useful in the reconnaissance stage of penetration testing, and relates them to CVE reports using the NIST CVE API. **Do not use Phidippus on sources you don't have permission to use it on.**

## 🛠️Setup and Dependencies
First, download Phidippus with the following command:
  -  pip install phidippus

Phidippus uses the httpx and beautifulsoup4 libraries.

# 🤖How It Works
The program first takes in arguments (url, verbose flag, login details):

**SCAN REGULAR:**

  phidippus -u <some url starting with http/https>
    
**SCAN WITH VERBOSE:**

   phidippus -u <some url starting with http/https> --verbose
    
**SCAN AN AUTHENTICATED AREA (if you have credentials):**

   phidippus -u <some url starting with http/https> \
        --login-url <url for login> \
        --username <username> \
        --password <password> \
        --login-data "user={username}&password={password}&login=submit"
        (you can also use verbose for this by just adding --verbose at the end)
        
### ***Remember to only use scanning tools for places you have permission to do so.***

It parses the arguments, and makes sure the url is valid (either starts with http:// or https://). Then, an httpx.AsynchClient instance is initialized. This is super important to the program because it automatically handles session cookies, so if you want to do an authenticated scan when you have login credentials, you can. If login arguments are provided, it calls the performLogin function. If that function fails, it'll just try a normal scan.

Once it sorts all that out, the actual scans are ran using await and asynchio.gather(). This way, other functions can be ran while one scanner waits for a network response. once a response is recieved, the scanning can continue. The scanner runs the following scanning functions:
  - **scanInfoGathering:** Makes a request to the target url and examines HTTP response headers for server headers, security headers, cookie flags, robots.txt, and sitemap.xml.
  - **scanNVD:** Uses the virtualMatchString parameter to relate findings from scanInfoGathering to active CVE reports from the specific banner version. If CVE's are found, they are added to the output report.
  - **scanXSS:** Parses the target url to identify existing GET parameters, and injects various XSS payloads. It then constructs a new url with the injected payload and makes a GET request. If the payload is reflected in the response, there is a potential XSS vulnerability.
  - **scanSQLi:** Test error based, boolean blind based, and time blind based SQL injections. For **error based**, it injects common SQL injection payloads into GET parameters and POST form fields and checks the response body for indications of SQL injections. For **boolean** and **time based**, it establishes a baseline length for an original, unattacked request. For **time based**, it injects time delay payloads, and if the response time is significantly longer than the baseline, a **time based** SQL injection is inferred. For **boolean based**, it sends two requests: one with a "true" payload (like ' AND 1=1--), and one with a "false" payload (like ' AND 1=2--). If the "true" condition response length is similar to the baselinee but the "false" condition is significantly different, a **boolean based** SQL injection is inferred.
  - **scanSecurityMisconfiguration:** A list of common sensitive paths is iterated through, and full urls are constructed for each path. GET requests are made to them, and if a 200 OK response is recieved, it checks for "Index of /" or "Directory listing for /" in the response, indicating that directory listing is enabled. Any 200 OK response to a sensitive path is reported, as it might expose confidential files or directories.

## 🧠Understanding The Report
After all the scans are done, it prints a summary of the findings, sorted by severity. **High** severity findings indicate vulnerabilities that can lead to extreme consequences for the application, its data, or its users. **Medium** severity findings indicate vulnerabilities that are significant, but require more specific conditions or chained exploits to achieve a high impact (even though they are still bad). **Low** severity findings indicate vulnerabilities point to minor security weaknesses, best practice violations, or configurations that don't pose a direct threat but could contribute to a bigger attack surface. **Informational** findings aren't vulnerabilities but provide penetration testers valuable information during the reconnaissance phase. CVE reports will be in another section at the bottom with severities and descriptions.
