#!/bin/sh

echo "start applicaiton(flight-operator) in production mode"

nohup java -Xmx1024m -jar flight-operator.war --spring.profiles.active=prod > /dev/null 2>&1 &

echo $! > catalina.pid
