worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 30
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end


@delayed_job_pid = nil

before_fork do |server, worker|
	@delayed_job_pid ||= spawn("bundle exec rake jobs:work")
	Rails.logger.info("Spawned Delayed Job #{@delayed_job_pid}")
end

# Put this is Procfile if ^ doesn't work
# worker:  bundle exec rake jobs:work