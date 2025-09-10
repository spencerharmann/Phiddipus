# @author Spencer Harman
# @file nvdRequests.py
# This program takes findings from vulnerabilityScanner.py and uses the NVD CVE API to
# relate them to real CVE reports.
import asyncio
import httpx
from urllib.parse import quote

# The base URL for the NVD CVE API
NVD_API_URL = "https://services.nvd.nist.gov/rest/json/cves/2.0"

# Headers to use for the API requests
HEADERS = {
    "User-Agent": "Web Vulnerability Scanner"
}

# Adds a finding to 'findings'
# Each finding contains a type, severity, description, url, and evidence, and is presented once the program
# finished scanning.
def addFinding( findings, findingType, severity, description, url, evidence ):
    findings.append( {
        "type": findingType,
        "severity": severity,
        "description": description,
        "url": url,
        "evidence": evidence
    } )

# Scans the NIST CVE API for a correlating CVE for the current server banner.
# It uses the virtualMatchString parameter to search for the proper banner and version
# and creates a url with it. If a CVE is found, it'll add it to the findings list.
async def scanNVD(  httpClient, detected_server_banners, findings, verbose=False ):
    print( "\n[+] Running NVD Scan..." )

    scanned_tech = set()

    for banner in detected_server_banners:
        tech_name = banner.get(  "name" )
        tech_version = banner.get(  "version" )
        tech_url = banner.get(  "url" )

        if not tech_name or not tech_version:
            continue

        tech_identifier = f"{tech_name}:{tech_version}"
        if tech_identifier in scanned_tech:
            continue
        scanned_tech.add( tech_identifier )

        # Construct a CPE match string to use with the API
        # Format is cpe:2.3:a:<vendor>:<product>:<version>:*:*:*:*:*:*:*
        match_string = f"cpe:2.3:a:{tech_name.lower()}:{tech_name.lower()}:{tech_version}"
        
        api_url = f"{NVD_API_URL}?virtualMatchString={quote( match_string )}"

        if verbose:
            print( f"    [verbose] Querying NVD for: {match_string}" )
            print( f"    [verbose] NVD API URL: {api_url}" )

        try:
            # API Delay
            await asyncio.sleep( 6 )
            
            response = await httpClient.get( api_url, headers=HEADERS, timeout=30.0 )
            response.raise_for_status()

            data = response.json()
            vulnerabilities = data.get( "vulnerabilities", [] )

            if vulnerabilities:
                print( f"    [!] Found {data.get( 'totalResults', 0 )} potential CVEs for {tech_name} {tech_version}" )
                for cve_item in vulnerabilities:
                    cve = cve_item.get( "cve", {} )
                    cve_id = cve.get( "id", "N/A" )
                    description = "No description available."
                    
                    for desc in cve.get( "descriptions", [] ):
                        if desc.get( "lang" ) == "en":
                            description = desc.get( "value", description )
                            break
                    
                    cvss_v3 = cve.get( "metrics", {} ).get( "cvssMetricV31", [] )
                    severity = "UNKNOWN"
                    if cvss_v3:
                        severity = cvss_v3[0].get( "cvssData", {} ).get( "baseSeverity", "UNKNOWN" )
                    else:
                        cvss_v2 = cve.get( "metrics", {} ).get( "cvssMetricV2", [] )
                        if cvss_v2:
                            severity = cvss_v2[0].get( "severity", "UNKNOWN" )

                    evidence = ( f"CVE: {cve_id}\n"
                                f"Severity: {severity}\n"
                                f"Description: {description}" )
                    
                    addFinding( findings, "Known Vulnerability ( CVE )", severity.capitalize(),
                               f"The version {tech_version} of {tech_name} is associated with {cve_id}.",
                               tech_url, evidence )
            else:
                if verbose:
                    print( f"    [+] No CVEs found for {tech_name} {tech_version}" )

        except httpx.HTTPStatusError as e:
            print( f"    [-] NVD API returned an error for '{match_string}': {e.response.status_code}" )
        except httpx.RequestError as e:
            print( f"    [-] Could not connect to NVD API: {e}" )
        except Exception as e:
            print( f"    [-] An unexpected error occurred during NVD scan: {e}" )