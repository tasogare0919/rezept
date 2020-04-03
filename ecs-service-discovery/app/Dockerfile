FROM ruby:2.6.5

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# Ruby
RUN gem update --system
RUN gem install bundler && gem update bundler

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN mkdir -p $APP_HOME/tmp/sockets
RUN mkdir -p $APP_HOME/tmp/pids

VOLUME $APP_HOME/tmp/sockets

RUN bundle