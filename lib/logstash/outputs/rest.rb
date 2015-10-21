require 'logstash/outputs/base'
require 'logstash/namespace'
require 'logstash/environment'
require 'rest_client'


class LogStash::Outputs::Rest < LogStash::Outputs::Base
  config_name 'rest'

  config :destination_proto, :validate => %w(http https), :required => true, :default => 'http'

  #     `"127.0.0.1"`
  config :destination_host, :validate => :string, :required => true, :default => '127.0.0.1'

  def initialize
  end

  public
  def register
    @xxx = @destination_proto
  end

# def register

  public
  def receive(event)
    #response = RestClient.post @destination_proto, {'x' => 1}.to_json, :content_type => :json, :accept => :json
    ss = "#{@destination_proto}://#{@destination_host}:#{@destination_port}";
    return ss
  end # def event
end # class LogStash::Outputs::Rest
