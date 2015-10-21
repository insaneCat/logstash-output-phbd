require 'rspec'
require 'logstash/devutils/rspec/spec_helper'
require 'logstash/outputs/rest'
require 'logstash/codecs/plain'
require 'logstash/event'
require 'logstash/plugin'

#describe LogStash::Outputs::Rest do
describe 'outputs/rest' do

  context 'registration' do
    it 'should register' do
      output = LogStash::Plugin.lookup('output', 'rest').new
      expect { output.register }.not_to raise_error
    end
  end

  context 'receive' do
    let(:sample_event) { LogStash::Event.new }
    let(:output) { LogStash::Outputs::Rest.new }

    before do
      output.register
    end

    describe 'receive message' do
      subject { output.receive(sample_event) }

      it 'returns a string' do
        expect(subject).to eq('Event received')
      end
    end
  end

end
