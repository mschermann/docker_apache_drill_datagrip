#!/bin/sh

# Give docker some time
sleep 5
su -c "cp /opt/drill/jars/jdbc-driver/drill-jdbc-all-${DRILL_VERSION}.jar /drill"
# Start the embedded service of drill (https://drill.apache.org/docs/installing-drill-in-embedded-mode/)
su -c "/opt/drill/bin/drill-embedded"
# Start the localhost service of drill
su -c "/opt/drill/bin/drill-localhost"
