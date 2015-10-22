require 'logstash/outputs/base'
require 'logstash/namespace'
require 'logstash/environment'
require 'rest_client'


# noinspection RubyResolve
class LogStash::Outputs::Rest < LogStash::Outputs::Base
  config_name 'rest'

  config :destination_service_protocol, :validate => %w(http https), :required => false, :default => 'http'
  config :destination_service_host, :validate => :string, :required => true, :default => '127.0.0.1'
  config :destination_service_port, :validate => :number, :required => false, :default => 80
  config :destination_service_path, :validate => :string, :required => false, :default => nil

  public
  def register
  end

  # def register

  public
  def receive(event)
    timestamp = event['@timestamp'].to_i

    #response = RestClient.post @destination_proto, {'x' => 1}.to_json, :content_type => :json, :accept => :json

    return @uri
  end

  private
  def build_url
    if @destination_service_path.nil?
      return "#{@destination_service_protocol}://#{@destination_service_host}:#{@destination_service_port}"
    else
      return "#{@destination_service_protocol}://#{@destination_service_host}:#{@destination_service_port}/#{@destination_service_path}"
    end
  end

end