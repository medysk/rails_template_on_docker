FROM ruby:3.0.2
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential default-mysql-client nodejs curl

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get -qq update && apt-get -y install yarn

# workdir
ARG APP_ROOT
ENV APP_ROOT ${APP_ROOT}
WORKDIR  ${APP_ROOT}

# gem
ENV BUNDLE_PATH=${GEM_HOME}
COPY Gemfile* ./
RUN bundle install

COPY . .
