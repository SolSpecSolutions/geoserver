FROM tomcat:9-jdk11

MAINTAINER SolSpec Development Team

# Set Environment variables
ENV GEOSERVER_VERSION="2.16.2"
ENV GEOSERVER_TAG="latest"
ENV GEOSERVER_DATA_DIR=/var/local/geoserver
ENV GEOSERVER_INSTALL_DIR=/usr/local/geoserver
ENV GEOSERVER_EXT_DIR=/var/local/geoserver-exts
ENV GEOSERVER_CSRF_WHITELIST="geo.solspec.io"

ADD conf/geoserver.xml /usr/local/tomcat/conf/Catalina/localhost/geoserver.xml
RUN mkdir ${GEOSERVER_DATA_DIR} \
    && mkdir ${GEOSERVER_INSTALL_DIR} \
        && cd ${GEOSERVER_INSTALL_DIR} \
        && wget --progress=bar:force:noscroll \
        http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip \
        && unzip geoserver-${GEOSERVER_VERSION}-war.zip \
        && unzip geoserver.war \
        && wget --progress=bar:force:noscroll \
        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-sec-keycloak-plugin.zip \
        && unzip -q -n geoserver-2.16-SNAPSHOT-sec-keycloak-plugin.zip -d WEB-INF/lib \
        && rm -rf geoserver-${GEOSERVER_VERSION}-war.zip geoserver.war target *.txt \
        && rm geoserver-2.16-SNAPSHOT-sec-keycloak-plugin.zip \
        && wget --progress=bar:force:noscroll \
        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-s3-geotiff-plugin.zip \
        && unzip -q -n geoserver-2.16-SNAPSHOT-s3-geotiff-plugin.zip -d WEB-INF/lib \
        && rm geoserver-2.16-SNAPSHOT-s3-geotiff-plugin.zip \
        && wget --progress=bar:force:noscroll \
        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-gwc-s3-plugin.zip \
        && unzip -q -n geoserver-2.16-SNAPSHOT-gwc-s3-plugin.zip -d WEB-INF/lib \
        && rm geoserver-2.16-SNAPSHOT-gwc-s3-plugin.zip \
        && wget --progress=bar:force:noscroll \
        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-gwc-sqlite-plugin.zip \
        && unzip -q -n geoserver-2.16-SNAPSHOT-gwc-sqlite-plugin.zip -d WEB-INF/lib \
        && rm geoserver-2.16-SNAPSHOT-gwc-sqlite-plugin.zip \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-python-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-python-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-python-plugin.zip  \
        && wget --progress=bar:force:noscroll \
        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-pgraster-plugin.zip \
        && unzip -q -n geoserver-2.16-SNAPSHOT-pgraster-plugin.zip -d WEB-INF/lib \
        && rm geoserver-2.16-SNAPSHOT-pgraster-plugin.zip  \
        && wget --progress=bar:force:noscroll \
        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-taskmanager-s3-plugin.zip \
        && unzip -q -n geoserver-2.16-SNAPSHOT-taskmanager-s3-plugin.zip -d WEB-INF/lib \
        && rm geoserver-2.16-SNAPSHOT-taskmanager-s3-plugin.zip  \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-mbtiles-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-mbtiles-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-mbtiles-plugin.zip  \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-mbstyle-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-mbstyle-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-mbstyle-plugin.zip  \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-gdal-wcs-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-gdal-wcs-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-gdal-wcs-plugin.zip  \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-gdal-wps-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-gdal-wps-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-gdal-wps-plugin.zip  \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-backup-restore-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-backup-restore-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-backup-restore-plugin.zip \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-wmts-styles-plugin.zip  \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-wmts-styles-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-wmts-styles-plugin.zip \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-wmts-multi-dimensional-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-wmts-multi-dimensional-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-wmts-multi-dimensional-plugin.zip \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-wps-download-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-wps-download-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-wps-download-plugin.zip \
#        && wget --progress=bar:force:noscroll \
#        https://build.geoserver.org/geoserver/2.16.x/community-latest/geoserver-2.16-SNAPSHOT-web-resource-browser-plugin.zip \
#        && unzip -q -n geoserver-2.16-SNAPSHOT-web-resource-browser-plugin.zip -d WEB-INF/lib \
#        && rm geoserver-2.16-SNAPSHOT-web-resource-browser-plugin.zip \
#        && ls /usr/local/geoserver/

# Enable CORS
RUN sed -i '\:</web-app>:i\
<filter>\n\
    <filter-name>CorsFilter</filter-name>\n\
    <filter-class>org.apache.catalina.filters.CorsFilter</filter-class>\n\
    <init-param>\n\
        <param-name>cors.allowed.origins</param-name>\n\
        <param-value>*</param-value>\n\
    </init-param>\n\
    <init-param>\n\
        <param-name>cors.allowed.methods</param-name>\n\
        <param-value>GET,POST,HEAD,OPTIONS,PUT</param-value>\n\
    </init-param>\n\
</filter>\n\
<filter-mapping>\n\
    <filter-name>CorsFilter</filter-name>\n\
    <url-pattern>/*</url-pattern>\n\
</filter-mapping>' ${GEOSERVER_INSTALL_DIR}/WEB-INF/web.xml

# Tomcat environment
ENV CATALINA_OPTS "-server -Djava.awt.headless=true \
        -XX:MaxPermSize=512m -Xms512m -Xmx2048m \
        -XX:+UseConcMarkSweepGC \
        -XX:NewSize=48m -XX:PermSize=256m \
        -XX:ParallelGCThreads=4 -Dfile.encoding=UTF8 \
        -Duser.timezone=GMT \
        -Djavax.servlet.request.encoding=UTF-8 \
        -Djavax.servlet.response.encoding=UTF-8 \
        -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR} \
        -DGEOSERVER_CSRF_WHITELIST=${GEOSERVER_CSRF_WHITELIST}"

# Create tomcat user to avoid root access
RUN addgroup --gid 1099 tomcat && useradd -m -u 1099 -g tomcat tomcat \
    && chown -R tomcat:tomcat . \
    && chown -R tomcat:tomcat ${GEOSERVER_DATA_DIR} \
    && chown -R tomcat:tomcat ${GEOSERVER_INSTALL_DIR}

# Modify tomcat server.xml file to deal with reverse proxy
RUN sed -i 's/"8443"/"8443" SSLEnabled="false" scheme="https" secure="true" /' /usr/local/tomcat/conf/server.xml

ADD keycloak_config.py /user/local/bin/keycloak_config.py
#RUN python /user/local/bin/keycloak_config.py

ADD start.sh /usr/local/bin/start.sh
ENTRYPOINT [ "/bin/sh", "/usr/local/bin/start.sh" ]

VOLUME ["${GEOSERVER_DATA_DIR}", "${GEOSERVER_EXT_DIR}"]

EXPOSE 8080
