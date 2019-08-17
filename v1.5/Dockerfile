FROM fluent/fluentd:v1.5.0-debian-1.0
MAINTAINER Baznai Cloud <info@banzaicloud.com>

RUN mkdir -p /fluentd/etc /fluentd/plugins
ONBUILD COPY plugins /fluentd/plugins/

USER root

RUN buildDeps="make gcc g++ libc-dev ruby-dev zlib1g-dev libz-dev git" \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && gem install \
        specific_install \
        fluent-plugin-remote-syslog \
        fluent-plugin-kubernetes_metadata_filter \
        fluent-plugin-webhdfs \
        fluent-plugin-elasticsearch \
        fluent-plugin-prometheus \
        fluent-plugin-s3 \
        fluent-plugin-rewrite-tag-filter \
        fluent-plugin-azurestorage \
        fluent-plugin-oss \
        fluent-plugin-grafana-loki

RUN gem specific_install -l https://github.com/banzaicloud/fluent-plugin-gcs.git
    
RUN gem sources --clear-all \
  && apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
         /home/fluent/.gem/ruby/2.3.0/cache/*.gem \
         /var/lib/gems/2.3.0/cache/*.gem \
  && apt-get purge -y $buildDeps

ADD fluent.conf /fluentd/etc/fluent.conf
WORKDIR  /home/fluent/

EXPOSE 24284
