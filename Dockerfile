FROM ruby:3

# as advised by official ruby image docs
RUN bundle config --global frozen 1

WORKDIR /srv/takethis

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["ruby", "app.rb"]
