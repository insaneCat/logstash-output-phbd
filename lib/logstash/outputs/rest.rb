require 'logstash/outputs/base'
require 'logstash/namespace'
require 'rest_client'


# noinspection RubyResolve
class LogStash::Outputs::Phbd < LogStash::Outputs::Base
  config_name 'phbd'

  config :destination_service_protocol, :validate => %w(http https), :required => false, :default => 'http'
  config :destination_service_host, :validate => :string, :required => false, :default => '127.0.0.1'
  config :destination_service_port, :validate => :number, :required => false, :default => 8444
  config :destination_service_path, :validate => :string, :required => false, :default => 'iu/index'

  config :index_name, :validate => :string, :required => true
  config :meta, :validate => :hash, :required => false
  config :source_type, :validate => :string, :required => false, :default => 'none'

  public
  def register
    @destination_url = build_url
  end

  public
  def receive(event)
    timestamp = event['@timestamp'].to_i

    event_phbd = map_event_to_phbd_event(event)

    #response = RestClient.post @destination_proto, {'x' => 1}.to_json, :content_type => :json, :accept => :json

    return @destination_url
  end

  private
  def build_url
    if @destination_service_path.nil?
      return "#{@destination_service_protocol}://#{@destination_service_host}:#{@destination_service_port}"
    else
      return "#{@destination_service_protocol}://#{@destination_service_host}:#{@destination_service_port}/#{@destination_service_path}"
    end
  end

  @destination_url = nil

  public
  def destination_url
    return @destination_url
  end

  private
  def map_event_to_phbd_event(event)
=begin
format of phbd event:

{
  "indexName":"i1",
  "sourceType" :"file",
  "source" : "c:\\f1",
  "timestamp" : 1441261422021,
  "body" :"one two three",
  "meta":{
    "field1" : "v2",
    "field2" : 777
  }
}
=end
  end
end