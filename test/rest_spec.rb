require 'rspec'
require 'logstash/devutils/rspec/spec_helper'
require 'logstash/outputs/rest'
require 'logstash/codecs/plain'
require 'logstash/event'
require 'logstash/plugin'

#describe LogStash::Outputs::Rest do
describe LogStash::Outputs::Rest do

  context 'registration' do
    it 'should register' do
      output = LogStash::Plugin.lookup('output', 'rest').new
      expect { output.register }.not_to raise_error
    end
  end

  context 'receive' do
    output = LogStash::Plugin.lookup('output', 'rest').new

    data = {'message' => 'hello', '@version' => '1', '@timestamp' => '2015-06-03T23:34:54.076Z', 'host' => 'x-ubuntu-trusty-64'}
    event = LogStash::Event.new data
    it 'returns a string' do
      result = output.receive(event)
      expect(result).to eq('Event received')
    end
  end

end
