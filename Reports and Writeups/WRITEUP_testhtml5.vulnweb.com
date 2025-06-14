This website was "http://testhtml5.vulnweb.com". This website is designed with intentional vulnerabilities,
and gives universal permission to hack. It is made to be exploited.

In this report, a lot of the vulnerabilities went with each other. Finding 2 and finding 10 both state that 
security headers are missing, which may allow XSS and Clickjacking. The XSS one is definitely true, as 8
other findings stated POST reflected XSS, with a bunch of different payloads.

XSS allows a third party (me in this case) to execute arbitrary code in the user's browser, which can expose
sensitive information or grant sensitive privileges. In this case, it allows the user to run arbitrary code
in the "username" section of a login, which can allow them to log in without an account, and possibly
expose sensitive information. This can be prevented by sanatizing the input from the client
instead of just leaving it as it is. 

When trying manually with the payloads in my program (just an alert popup), it allows a popup to happen 
every single time.

Other than those, finding 12 states an information discolsure: "Server: nginx/1.19.0". This exposes the type 
of server it is, which allows an attacker to know exactly what kind of system they are dealing with, and
can adjust their attack vector accordingly.

This is an extremely unsecure website.