require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

# require 'test/unit'
# require 'minitest'
# require 'minitest/autorun'
# require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))


require 'fun_with_testing'
# require_relative File.join( "classes", "mock_unit_test" )

class FunWith::Testing::MyTestCase < FunWith::Testing::TestCase
end

