require 'rspec'
require 'logstash/devutils/rspec/spec_helper'
require 'logstash/outputs/rest'
require 'logstash/codecs/plain'
require 'logstash/event'
require 'logstash/plugin'

describe LogStash::Outputs::Phbd do

  context 'registration' do
    it 'should register' do
      output = LogStash::Plugin.lookup('output', 'rest').new
      expect { output.register }.not_to raise_error
    end
  end

  context 'misc' do
    it 'should fail if @destination_service_protocol not set to [http] or [https]' do
      expect {
        output = LogStash::Plugin.lookup('output', 'rest').new('destination_service_protocol' => 'fake')
        output.register
      }.to raise_error
    end

    it 'should construct url from conf1' do
      expected = 'https://0.0.0.0:444'
      output = LogStash::Plugin.lookup('output', 'rest').new(
          'destination_service_protocol' => 'https',
          'destination_service_host' => '0.0.0.0',
          'destination_service_port' => 444
      )
      output.register
      expect(output.destination_url).to eq expected
    end

    it 'should construct url from conf2' do
      expected = 'http://0.0.0.0:444/x/y'
      output = LogStash::Plugin.lookup('output', 'rest').new(
          'destination_service_protocol' => 'http',
          'destination_service_host' => '0.0.0.0',
          'destination_service_port' => 444,
          'destination_service_path' => 'x/y'
      )
      output.register
      expect(output.destination_url).to eq expected
    end
  end

=begin
  context 'receive' do
    output = LogStash::Plugin.lookup('output', 'phbd').new

    data = {'message' => 'hello', '@version' => '1', '@timestamp' => '2015-06-03T23:34:54.076Z', 'host' => 'x-ubuntu-trusty-64'}
    event = LogStash::Event.new data
    it 'returns a string' do
      result = output.receive(event)
      expect(result).to eq('Event received')
    end
  end
=end

end
