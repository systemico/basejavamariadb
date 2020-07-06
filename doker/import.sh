#!/bin/bash

cd /docker-entrypoint-initdb.d/
mysql --user=root --password=root DB_SLIM < model-dv.sql