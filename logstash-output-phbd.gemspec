# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'logstash-output-rest'
  spec.version       = '0.0.1'
  spec.licenses = ['Apache License (2.0)']
  spec.summary = 'This plugin for output to rest service.'
  spec.description = 'This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program'
  spec.authors = ['Anton Konovalov']
  spec.email = 'hellbla3e@gmail.com'
  spec.homepage = 'http://www.elastic.co/guide/en/logstash/current/index.html'


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Tests
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  spec.metadata = { 'logstash_plugin' => 'true', 'logstash_group' => 'output'}

  # Gem dependencies
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'logstash-core', '>= 2.0.0.beta2', '< 3.0.0'
  spec.add_runtime_dependency 'logstash-codec-plain'
  spec.add_development_dependency 'logstash-devutils'
  spec.add_development_dependency 'rest-client', '~> 1.8'
end
