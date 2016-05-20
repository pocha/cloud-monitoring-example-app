class AgentDataWorker
  include Shoryuken::Worker

  shoryuken_options queue: "agent_data", auto_delete: true, body_parser: :json

  def perform(sqs_msg, data)
    puts "data #{data}"
    begin
      agent= Agent.find_or_create_by(ip: data["ip"])
      agent = Agent.new if agent.nil?
      agent.cpu = data["cpu"]
      agent.disk = data["disk"]
      agent.memory = data["memory"]
      agent.save!
    rescue Exception => e
      puts e.message 
      puts e.backtrace.inspect
    end
  end
end
