FROM ruby:2.4

RUN mkdir /app
WORKDIR /app
ADD . /app
RUN bundle
