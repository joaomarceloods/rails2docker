FROM ruby:2.7.1-buster
WORKDIR /app

# Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends \
  nodejs \
  yarn
RUN apt-get clean

COPY package.json yarn.lock ./
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

COPY . .

EXPOSE 3000
CMD [ "puma", "-C", "config/puma.rb" ]
