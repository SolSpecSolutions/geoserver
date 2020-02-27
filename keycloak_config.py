
from xml.dom import minidom
import os

main_config = minidom.parse("/var/local/geoserver/security/config.xml")
ssl_config = minidom.parse("/var/local/geoserver/security/filter/sslFilter/config.xml")

filters = main_config.getElementsByTagName("filters")

# Modify Filters
for filter in filters:
    if filter.getAttribute("name") == "web":
        nodes = filter.getElementsByTagName("filter")
        for node in nodes:
            filter.removeChild(node)
        newFilter = main_config.createElement("filter")
        text = main_config.createTextNode("keycloak-adapter")
        newFilter.appendChild(text)
        filter.appendChild(newFilter)

file_handle = open("/var/local/geoserver/security/config.xml","wb")
main_config.writexml(file_handle)
file_handle.close()

# Get and decrement ID
id = ssl_config.getElementsByTagName("id")[0].firstChild.nodeValue[:-1] + str(int(ssl_config.getElementsByTagName("id")[0].firstChild.nodeValue[-1])-1)

xmlString = """<keycloakAdapter>
  <id>4c017111:17062f9f24d:-7fe5</id>
  <name>keycloak-adapter</name>
  <className>org.geoserver.security.keycloak.GeoServerKeycloakFilter</className>
  <adapterConfig>{&#xd;
  &quot;realm&quot;: &quot;SolSpec&quot;,&#xd;
  &quot;auth-server-url&quot;: &quot;https://keycloak.solspec.io/auth/&quot;,&#xd;
  &quot;ssl-required&quot;: &quot;external&quot;,&#xd;
  &quot;resource&quot;: &quot;geoserver-client&quot;,&#xd;
  &quot;credentials&quot;: {&#xd;
    &quot;secret&quot;: &quot;27ab0535-97cc-4a6f-b052-e0c17eddc035&quot;&#xd;
  },&#xd;
  &quot;use-resource-role-mappings&quot;: true,&#xd;
  &quot;confidential-port&quot;: 0&#xd;
}</adapterConfig>
</keycloakAdapter>"""

keycloak_config = minidom.parseString(xmlString)
keycloak_config.getElementsByTagName("id")[0].firstChild.nodeValue = id

os.makedirs("/var/local/geoserver/security/filter/keycloak-adapter")

file_handle = open("/var/local/geoserver/security/config.xml","wb")
keycloak_config.writexml(file_handle)
file_handle.close()
