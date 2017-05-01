# To start the background process:
# BACKGROUND=y PIDFILE=tmp/pids/process_all.pid LOG_LEVEL=info rake process_all:start

# To kill the process (macOS):
# kill $(cat tmp/pids/process_all.pid)

namespace :process_all do

  task start: :environment do

    Rails.logger       = Logger.new(Rails.root.join('log', 'process_all.log'))
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

        classrooms = Classroom.all
        classrooms.each do |classroom|

          Report.transaction do
            success = classroom.students.map do |std|
              (report = Report.find_by_student_date(std.id)) ?
                report.update_attributes(draft: false) : true
            end

            if !success.all?
              log = "Error sending reports from classroom ID: #{classroom.id} at: #{now.strftime('%H:%M')}"
              Rails.logger.info log
              raise ActiveRecord::Rollback
            else
              log = "Sent reports from classroom ID: #{classroom.id} at: #{now.strftime('%H:%M')}"
              Rails.logger.info log
            end
          end if !classroom.nil?

        end

        sent_all = true
        log = "sent_all was set to #{sent_all}"
        Rails.logger.info log

      elsif now.strftime('%H:%M') == '00:00'

        sent_all = false
        log = "It is a new day: #{now.to_date} and sent_all was set to #{sent_all}"
        Rails.logger.info log

        students = Student.all
        students.each do |student|
          student.update_attribute(:absence, "false")
        end
        log = "All students were set present"
        Rails.logger.info log

      else

        Rails.logger.info "Nothing to do. Sleeping..."

      end

      sleep 50

    end

  end

end
