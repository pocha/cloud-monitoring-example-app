namespace :daemon do
  desc "start daemon & run every 1 minute"
  task start: :environment do
    
    Rails.logger       = Logger.new(Rails.root.join('log', 'daemon.log'))
    Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

    Process.daemon(true, true)

    File.open("daemon.pid", 'w') { |f| f << Process.pid }

    Signal.trap('TERM') { 
      Rails.logger.info "Got TERM. Stopping daemon"
      abort 
    }

    Rails.logger.info "Start daemon..."

    require 'aws-sdk'
    sqs = Aws::SQS::Client.new(
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :region => ENV['AWS_REGION']
    )
    queue_url = sqs.create_queue({ queue_name:ENV['QUEUE_NAME'] }).queue_url

    require 'usagewatch'
    require 'open-uri'
    remote_ip = open('http://whatismyip.akamai.com').read

    loop do
      usw = Usagewatch 
      Rails.logger.info "#{usw.uw_diskused} #{usw.uw_cpuused} #{usw.uw_memused}"
      resp = sqs.send_message({
        queue_url: queue_url,
        message_body: {ip: remote_ip, disk: usw.uw_diskused, cpu: usw.uw_cpuused, memory: usw.uw_memused}.to_json
      })   
      Rails.logger.info "data sent to queue. Response id #{resp.message_id}"
       
      sleep ENV["INTERVAL"].to_i || 60
    end
  end

end
