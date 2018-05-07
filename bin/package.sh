#!/usr/bin/env bash

DESKTOP_DIR="/Users/xuyaguang/Desktop/"

CURRENT_DIR=$(cd `dirname $0`; pwd)
PARENT_DIR=${CURRENT_DIR%/*}
BASE_DIR=${PARENT_DIR%/*}


INSURE_DIR=$BASE_DIR"/flight-operator"
echo cd $INSURE_DIR
cd $INSURE_DIR
mvn clean compile package -Dmaven.test.skip=true
if [ $? -eq 1 ]; then
	echo "Package flight-operator failed"
	exit 1
fi
INSURE_JAR_DIR=$INSURE_DIR"/target/flight-operator.war"
cp -f $INSURE_JAR_DIR $DESKTOP_DIR

