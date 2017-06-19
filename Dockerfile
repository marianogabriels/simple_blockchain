FROM ruby:2.4

RUN mkdir /app
RUN mkdir /app/lib/
RUN mkdir /app/lib/simple_blockchain
WORKDIR /app

ADD lib/simple_blockchain/version.rb /app/lib/simple_blockchain
ADD Gemfile Gemfile.lock simple_blockchain.gemspec /app/

RUN ls /app
RUN bundle install -j 8

ADD . /app

CMD rackup
EXPOSE 8081 8393
