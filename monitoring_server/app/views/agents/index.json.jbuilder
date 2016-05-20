json.array!(@agents) do |agent|
  json.extract! agent, :id, :ip, :cpu, :disk, :memory
  json.url agent_url(agent, format: :json)
end
