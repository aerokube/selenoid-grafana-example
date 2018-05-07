FROM grafana/grafana:latest

USER root
RUN apt-get update && \
    apt-get -y install procps
USER solr 

COPY ./grafana-run.sh /
ENTRYPOINT ["/grafana-run.sh"]
