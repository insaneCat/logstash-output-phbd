require 'rspec'
require 'logstash/devutils/rspec/spec_helper'
require 'logstash/outputs/phbd'
require 'logstash/codecs/plain'
require 'logstash/event'
require 'logstash/plugin'

describe LogStash::Outputs::Phbd do

  context 'registration' do
    it 'should register' do
      output = LogStash::Plugin.lookup('output', 'phbd').new(
          'index_name' => 'test'
      )
      expect { output.register }.not_to raise_error
    end
  end

  context 'misc' do
    it 'should fail if @destination_service_protocol not set to [http] or [https]' do
      expect {
        output = LogStash::Plugin.lookup('output', 'phbd').new(
            'destination_service_protocol' => 'fake',
            'index_name' => 'test'
        )
        output.register
      }.to raise_error
    end

    it 'should construct url from conf1' do
      expected = 'https://0.0.0.0:444/iu/index'
      output = LogStash::Plugin.lookup('output', 'phbd').new(
          'destination_service_protocol' => 'https',
          'destination_service_host' => '0.0.0.0',
          'destination_service_port' => 444,
          'index_name' => 'test'
      )
      output.register
      expect(output.destination_url).to eq expected
    end

    it 'should construct url from conf2' do
      expected = 'http://0.0.0.0:8444'
      output = LogStash::Plugin.lookup('output', 'phbd').new(
          'destination_service_protocol' => 'http',
          'destination_service_host' => '0.0.0.0',
          'destination_service_path' => nil,
          'index_name' => 'test'
      )
      output.register
      expect(output.destination_url).to eq expected
    end
  end

  context 'receive' do
    output = LogStash::Plugin.lookup('output', 'phbd').new(
        'index_name' => 'test'
    )

    data = {'message' => 'hello', '@version' => '1', '@timestamp' => '2015-06-03T23:34:54.076Z', 'host' => 'x-ubuntu-trusty-64'}
    event = LogStash::Event.new data
    it 'returns a string' do
      result = output.receive(event)
      expect(result).to eq('Event received')
    end
  end

end
