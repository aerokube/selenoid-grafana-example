## Telegraf + InfluxDB + Grafana example

This repo allows fast deployment of own Grafana Dashboard.
Dashboard itself can be found at [Grafana/Dashboards/Selenoid Stats](https://grafana.com/dashboards/3632)

### Quick start

- Change `INFLUXDB_URI` env var for telegraf to your host in `docker-compose.yml`
- `docker-compose up`
- Go to `localhost:3000`

NOTE: This will not work as is on mac-osx. You should change hosts and ports in config to appropriate values
(usually host ip, accessible from containers can be found with `ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1` command)

### Requirements and recommendations

- You probably want to deploy influxdb + grafana on separate host from selenoid to avoid negative impact of selenoid to metrics collection process.
- You probably want to deploy telegraf on each selenoid host to allow system metrics collection.
- If you don't want to get system metrics, you can just define all selenoid status endpoints in telegraf config, but you should change dashboard, to group by `server` then (instead of host) - see *Templating* Grafana feature.

### Features

- Grafana gets preprepared influxdb datasource on startup
- Telegraf reports all metrics as mentioned in [Sending Statistics to External Systems](http://aerokube.com/selenoid/latest/#_sending_statistics_to_external_systems) help section
- On dashboard you can filter by `host`, `browser` and `quota`
