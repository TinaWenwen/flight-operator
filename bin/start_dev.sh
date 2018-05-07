#!/bin/sh

echo "start applicaiton(flight-operator) in develop mode"

nohup java -Xmx1024m -jar flight-operator.war --spring.profiles.active=dev > /dev/null 2>&1 &

echo $! > catalina.pid
