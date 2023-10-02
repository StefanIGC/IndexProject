FROM ruby:3.2.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle install

COPY . .

CMD  bundle exec rails server -b 0.0.0.0 -p 3000
