FROM ruby:2.5.1

RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs

ENV APP_HOME /web

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

COPY ruby-entrypoint.sh /usr/src/
RUN ["chmod", "+x", "/usr/src/ruby-entrypoint.sh"]