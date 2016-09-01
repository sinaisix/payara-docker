FROM airhacks/derbydb
MAINTAINER Adam Bien, adam-bien.com
ENV PAYARA_ARCHIVE payara41
ENV DOMAIN_NAME domain1
ENV INSTALL_DIR /opt
RUN curl -o ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip -L http://bit.ly/1Gm0GIw
RUN unzip ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip -d /opt
ENV PAYARA_HOME ${INSTALL_DIR}/payara41/glassfish
ENV EXEC ${PAYARA_HOME}/bin
ENV DEPLOYMENT_DIR ${PAYARA_HOME}/domains/${DOMAIN_NAME}/autodeploy/
ENTRYPOINT asadmin start-domain --verbose ${DOMAIN_NAME}
WORKDIR /opt/payara41/glassfish/bin
EXPOSE 4848 8009 8080 8181 1527
RUN echo ${DOMAIN_NAME}
RUN asadmin start-domain ${DOMAIN_NAME} && \
    asadmin delete-jvm-options -Xmx512m  && \
    asadmin create-jvm-options -Xms2G  && \
    asadmin create-jvm-options -Xmx2G  && \
    asadmin stop-domain ${DOMAIN_NAME}
