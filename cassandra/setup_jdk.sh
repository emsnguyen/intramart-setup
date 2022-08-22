#!/bin/sh

tar zxvf /jdk-8u172-linux-x64.tar.gz
mkdir -p /usr/local/java
mv jdk1.8.0_172 /usr/local/java/jdk1.8.0_172
ln -s /usr/local/java/jdk1.8.0_172 /usr/local/java/jdk