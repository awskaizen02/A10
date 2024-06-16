FROM tomcat:10

LABEL maintainer="hippo"

ADD **/*.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
