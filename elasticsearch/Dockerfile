FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.3

FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.3

RUN mkdir -p /data/production/nodes
RUN mkdir -p /data/development/nodes
RUN mkdir -p /data/test/nodes

RUN chown -R elasticsearch /data/production
RUN chown -R elasticsearch /data/development
RUN chown -R elasticsearch /data/test
