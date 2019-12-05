FROM ruby:2.6-alpine

ENV BUILD_PACKAGES bash ruby-dev build-base cmake openssl-dev
ENV RUNTIME_PACKAGES git

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUNTIME_PACKAGES && \
    rm -rf /var/cache/apk/*

COPY Gemfile /Gemfile
RUN bundle install
