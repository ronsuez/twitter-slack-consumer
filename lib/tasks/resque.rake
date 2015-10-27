
require "resque/tasks"
require 'resque/scheduler/tasks'
require 'resque/pool/tasks'


task "resque:setup" => :environment

namespace :resque do
  task :setup do
    require 'resque'

    if Rails.env == 'production'
		  uri = URI.parse(ENV["REDIS_URL"])
      Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    else
      Resque.redis = Redis.new
      Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection } 
    end
  end
end