#!/bin/sh

curl -L -C - -O https://archive.apache.org/dist/cassandra/1.1.12/apache-cassandra-1.1.12-bin.tar.gz
tar -zxvf apache-cassandra-1.1.12-bin.tar.gz
rm apache-cassandra-1.1.12-bin.tar.gz

mkdir -p /usr/local/apache-cassandra
mv apache-cassandra-1.1.12 /usr/local/apache-cassandra/apache-cassandra-1.1.12
ln -s /usr/local/apache-cassandra/apache-cassandra-1.1.12 /usr/local/apache-cassandra/apache-cassandra

sed -i -e "s/Xss180k/Xss228k/g" /usr/local/apache-cassandra/apache-cassandra/conf/cassandra-env.sh
sed -i -e "s/listen_address: localhost/listen_address:/g" /usr/local/apache-cassandra/apache-cassandra/conf/cassandra.yaml
sed -i -e "s/rpc_address: localhost/rpc_address:/g" /usr/local/apache-cassandra/apache-cassandra/conf/cassandra.yaml