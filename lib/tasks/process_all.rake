namespace :process_all do

  task start: :environment do

    Rails.logger       = Logger.new(Rails.root.join('log', 'daemon.log'))
    Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

    if ENV['BACKGROUND']
      Process.daemon(true, true)
    end

    if ENV['PIDFILE']
      File.open(ENV['PIDFILE'], 'w') { |f| f << Process.pid }
    end

    Signal.trap('TERM') { abort }

    Rails.logger.info "Starting daemon..."

    sent_all = false

    loop do

      now = Time.now

      if now.strftime('%H:%M') == '18:00' and sent_all == false

        Classroom.each do |classroom|
          send_all_reports_path(classroom_id: classroom.id)
          log = "Sent reports from classroom #{classroom.name}, ID: #{classroom.id} at: #{now.strftime('%H:%M')}"
          Rails.logger.info log
        end

        sent_all = true
        log = "sent_all was set to #{sent_all}"
        Rails.logger.info log

      elsif now.strftime('%H:%M') == '00:00'
        sent_all = false
        log = "It is a new day: #{now.to_date} and sent_all was set to #{sent_all}"
        Rails.logger.info log

        Students.each do |student|
          student.update_attribute(:absence, "false")
        end
        log = "All students were set present"
        Rails.logger.info log

      else
        Rails.logger.info "Nothing to do. Sleeping..."
      end

      sleep 30

    end

  end

end
