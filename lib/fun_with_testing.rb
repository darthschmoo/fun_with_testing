require 'bundler'
require 'byebug'
require 'minitest'
require 'minitest/autorun'
require 'shoulda'
require 'juwelier'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end


files = Dir.glob( File.join( File.dirname(__FILE__), "fun_with", "testing", "**", "*.rb" ) )
files.map!{ |f| f.gsub( /\.rb$/, '' ) }

# TODO: Risk of infinite loops here
while files.length > 0
  begin
    file = files.shift
    require file
  rescue NameError => e   # if the class/module depends on a not-yet-defined class/module
    warn "#{e.class}: #{e.message}"
    files << file
  end
end

FunWith::Testing.send( :include, FunWith::Testing::Assertions::Basics )
