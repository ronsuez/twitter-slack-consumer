resque: env QUEUE=slack TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 COUNT=2 RAILS_ENV=production bundle exec rake resque:work
web: thin start -p $PORT
