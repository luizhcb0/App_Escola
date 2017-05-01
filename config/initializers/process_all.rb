PROCESS_ALL_PID_PATH = "#{Rails.root}/tmp/pids/process_all.pid"

def start_daemon

  if (File.basename($0) == 'rake') || $rails_rake_task
    return
  end

  Thread.new do
    system("BACKGROUND=y PIDFILE=tmp/pids/process_all.pid LOG_LEVEL=info rake process_all:start")
  end
end

def daemon_is_running?
  pid = File.read(PROCESS_ALL_PID_PATH).strip
  Process.kill(0, pid.to_i)
  true
rescue Errno::ENOENT, Errno::ESRCH   # file or process not found
  false
end

start_daemon unless daemon_is_running?
