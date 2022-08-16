FROM tomcat
COPY ./target/SampleWebApp /usr/local/tomcat/SampleWebApp
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
EXPOSE 8080
