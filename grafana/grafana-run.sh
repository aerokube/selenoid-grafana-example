#!/bin/bash
set -e

./run.sh "${@}" &
timeout 10 bash -c "until </dev/tcp/localhost/3000; do sleep 1; done"

curl -s -H "Content-Type: application/json" \
    -XPOST http://admin:admin@localhost:3000/api/datasources \
    -d @- <<EOF
{
    "name": "influxdb",
    "type": "influxdb",
    "access": "proxy",
    "url": "${INFLUXDB_URI}",
    "database": "${INFLUXDB_DB}",
    "user":"${INFLUXDB_USER}",
    "password":"${INFLUXDB_USER_PASSWORD}"
}
EOF

pkill grafana-server
timeout 10 bash -c "while </dev/tcp/localhost/3000; do sleep 1; done"

exec ./run.sh "${@}"
