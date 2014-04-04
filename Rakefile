# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "fun_with_testing"
  gem.homepage = "http://github.com/darthschmoo/fun_with_testing"
  gem.license = "MIT"
  gem.summary = "A place to stash Test::Unit assertions I've found handy."
  gem.description = "A place to stash Test::Unit assertions I've found handy. Use at your own risk"
  gem.email = "keeputahweird@gmail.com"
  gem.authors = ["Bryce Anderson"]
  
  gem.files = Dir.glob( File.join( ".", "lib", "**", "*.rb" ) ) + 
              Dir.glob( File.join( ".", "test", "**", "*" ) ) +
              %w( Gemfile Rakefile LICENSE.txt README.rdoc VERSION CHANGELOG.markdown )
  
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

# require 'rcov/rcovtask'
# Rcov::RcovTask.new do |test|
#   test.libs << 'test'
#   test.pattern = 'test/**/test_*.rb'
#   test.verbose = true
#   test.rcov_opts << '--exclude "gems/*"'
# end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "fun_with_testing #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end