resque: env QUEUE=slack TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7  RAILS_ENV=production bundle exec rake resque:work
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-production}
