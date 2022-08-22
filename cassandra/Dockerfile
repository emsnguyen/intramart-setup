FROM mycentos:6.9

EXPOSE 22 9160

ENV DEBIAN_FRONTEND noninteractive

# yum
RUN yum -y update && yum clean all
RUN yum -y upgrade && yum -y update && yum clean all

# JDK
COPY jdk-8u172-linux-x64.tar.gz /jdk-8u172-linux-x64.tar.gz
COPY setup_jdk.sh /setup_jdk.sh
RUN chmod u+x /setup_jdk.sh
RUN /setup_jdk.sh
RUN rm -f /setup_jdk.sh
ENV JAVA_HOME /usr/local/java/jdk
ENV PATH /usr/local/java/jdk/bin:$PATH
RUN echo 'JAVA_HOME=/usr/local/java/jdk' >> /root/.bashrc
RUN echo 'PATH=$PATH:/usr/local/java/jdk/bin' >> /root/.bashrc
RUN rm -f /jdk-8u172-linux-x64.tar.gz

# Cassandra
COPY setup_cassandra.sh /setup_cassandra.sh
RUN chmod u+x /setup_cassandra.sh
RUN /setup_cassandra.sh
RUN rm -f /setup_cassandra.sh
ENV PATH $PATH:/usr/local/apache-cassandra/apache-cassandra/bin
RUN echo 'PATH=$PATH:/usr/local/apache-cassandra/apache-cassandra/bin' >> /root/.bashrc

COPY run.sh /run.sh
RUN chmod u+x /run.sh

RUN updatedb

CMD /run.sh