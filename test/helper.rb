require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'fun_with_testing'

class Test::Unit::TestCase
end

# Any subclass of Test::Unit::TestCase seems to automatically hook into the test suite.
# Therefore, calling a test to see if it returns false makes the suite fail.  Including
# to this class instead prevents that.  I may need to more closely mimic Test::Unit::TestCase
# in order to test messages properly.
class MockUnitTest
  def build_message( m, m2, obj = nil)
    "#{m} #{m2} #{obj}"
  end
  
  def assert_block( msg, &block )
    yield
  end
end

class FunWith::Testing::TestCase < Test::Unit::TestCase
  def extended_test_case( &block )
    @case_class = Class.new( MockUnitTest )
    @case_class.send( :include, FunWith::Testing )
    @case = @case_class.new
    yield if block_given?
  end
end
