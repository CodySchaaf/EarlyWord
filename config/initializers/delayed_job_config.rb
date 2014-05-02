Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 30.minutes
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 1.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = 'default'
# Having delayed jobs set to false when testing prevents you from testing these jobs, and if you try can cause never ending loops :(
# Delayed::Worker.delay_jobs = !Rails.env.test?