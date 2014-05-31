require 'bundler'
require 'debugger'
require 'minitest'
require 'minitest/autorun'
require 'shoulda'
require 'jeweler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end


files = Dir.glob( File.join( File.dirname(__FILE__), "fun_with", "testing", "**", "*.rb" ) )

for file in files.map{ |f| f.gsub(/\.rb$/, '') }
  require file
end


# FunWith::Testing.extend( FunWith::Testing::FwtExtensions )
# FunWith::Testing.assertion_modules << FunWith::Testing::Assertions::ActiveRecord
# FunWith::Testing.assertion_modules << FunWith::Testing::Assertions::Basics

FunWith::Testing.send( :include, FunWith::Testing::Assertions::Basics )
FunWith::Testing.send( :include, FunWith::Testing::Assertions::ActiveRecord )
