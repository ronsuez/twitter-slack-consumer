resque: env QUEUE=slack TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 COUNT=2 RAILS_ENV=production bundle exec rake resque:workers
web: thin start -p $PORT
