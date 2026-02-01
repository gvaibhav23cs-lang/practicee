FROM tomcat:9-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY studentlogin.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8081

CMD ["catalina.sh", "run"]
