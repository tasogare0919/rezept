FROM ruby:2.7.1

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV EDITOR vim

RUN apt-get update

RUN gem update --system
RUN gem install bundler

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN mkdir -p $APP_HOME/tmp/pids
RUN mkdir -p $APP_HOME/tmp/sockets

VOLUME $APP_HOME/tmp

ARG DEPLOYMENT
RUN bundle config deployment $DEPLOYMENT
RUN bundle