FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /enjoy_backmusic
COPY Gemfile /enjoy_backmusic/Gemfile
COPY Gemfile.lock /enjoy_backmusic/Gemfile.lock
RUN bundle install
COPY . /enjoy_backmusic

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]