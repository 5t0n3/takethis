FROM ruby:3

# as advised by official ruby image docs
RUN bundle config --global frozen 1

WORKDIR /srv/takethis

# create attachments directory
RUN mkdir attachments

# install deps
COPY Gemfile Gemfile.lock ./
RUN bundle install

# copy code in
COPY . .

CMD ["ruby", "app.rb"]
