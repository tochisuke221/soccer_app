FROM ruby:2.6.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

RUN apt-get install -y nodejs npm && npm install n -g && n 14.17.0

WORKDIR /soccer_app
COPY Gemfile /soccer_app/Gemfile
COPY Gemfile.lock /soccer_app/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /soccer_app


RUN yarn install --check-files
RUN bundle exec rails webpacker:compile
