FROM ubuntu:16.04
RUN apt-get clean && apt-get update
RUN apt-get install git -y
RUN apt-get install default-jdk -y
RUN apt-get install maven -y
RUN apt-get install wget -y
RUN mkdir /usr/local/tomcat

RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz
RUN cd /tmp
RUN tar -xzvf apache-tomcat-8.5.*.tar.gz
RUN cp -Rv /apache-tomcat-8.5.*/* /usr/local/tomcat/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd /boxfuse-sample-java-war-hello && mvn clean package

RUN cp /boxfuse-sample-java-war-hello/target/hello-*.war /usr/local/tomcat*/webapps/
EXPOSE 80

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
