require 'rubygems'
require 'rake'

begin require "metric_fu" rescue LoadError; end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "clinical"
    gem.summary = %Q{a library for accessing data from ClinicalTrials.gov}
    gem.email = "dpickett@enlightsolutions.com"
    gem.homepage = "http://github.com/dpickett/clinical"
    gem.authors = ["Dan Pickett"]
    gem.add_dependency("jnunemaker-httparty", ">= 0.4.3")
    gem.add_dependency("jnunemaker-happymapper", ">= 0.2.5")
    gem.add_dependency("mislav-will_paginate", ">= 2.3.11")
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

namespace :rcov do
  require 'rcov/rcovtask'
  Rcov::RcovTask.new(:tests) do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.rcov_opts = %w{--aggregate coverage.data --exclude osx\/objc,gems\/,spec\/}
    test.verbose = true
  end  
  
  require 'cucumber/rake/task'  
  Cucumber::Rake::Task.new(:cucumber) do |t|    
    t.rcov = true
    t.rcov_opts = %w{--aggregate coverage.data --exclude osx\/objc,gems\/,features\/,spec\/ -o "features_rcov"}
  end
end
begin
  desc "Run both specs and features to generate aggregated coverage"
  task :rcov do |t|
    rm "coverage.data" if File.exist?("coverage.data")
    Rake::Task["rcov:cucumber"].invoke
    Rake::Task["rcov:tests"].invoke
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
  
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "clinical #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

