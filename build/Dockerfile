# THis is the build file for Apache Drill
# Adapted from https://github.com/apache/drill/blob/master/distribution/Dockerfile

FROM centos:latest

# Make sure that everything is up to date.
RUN yum -y upgrade

# Tools
RUN yum -y install initscripts which unzip wget net-tools

# Drill requires Java
RUN yum -y install java-1.8.0-openjdk-devel

#Clean up
RUN yum clean all
RUN rm -rf /var/cache/yum

# Make the current version of drill available
ARG DRILL_VERSION

# Get drill
RUN wget http://apache.mirrors.hoobly.com/drill/drill-$DRILL_VERSION/apache-drill-$DRILL_VERSION.tar.gz

# Create the install directory for drill
RUN mkdir /opt/drill

# extract drill to the install directory
RUN tar -xvzf apache-drill-$DRILL_VERSION.tar.gz --directory=/opt/drill --strip-components 1

# make a work directory
RUN mkdir /drill
WORKDIR /drill

ADD run_drill.sh /drill
