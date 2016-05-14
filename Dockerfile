# generate gemfile.lock
#   docker-compose run app bundle install
# uncomment and rebuild image
#   docker-compose build app
# boostrap rails app
#   docker-compose run --user "1000:$(id -g)" app rails new --skip-bundle .

# Use this to work inside the docker container
#   docker-compose run app bash

# base image
FROM ruby:2.3

# install some requirements
RUN set -ex \
  && apt-get update \
  && apt-get install -y \
    nodejs

#  throw errors if Gemfile has been modified since Gemfile.lock
# comment out while bootstrapping app
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# install required gems from gemfile
# comment out while bootstrapping app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

# copy the code
COPY . /usr/src/app

# default command
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
