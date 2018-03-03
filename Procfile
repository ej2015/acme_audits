web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c ${RAILS_MAX_THREADS:-10}  -t 20
