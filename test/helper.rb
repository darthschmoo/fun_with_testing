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
require_relative File.join( "classes", "mock_unit_test" )

class FunWith::Testing::MyTestCase < FunWith::Testing::TestCase
  def extended_test_case( &block )
    @case_class = Class.new( FunWith::Testing::MockUnitTest )

    @case = @case_class.new( "MockUnitTest" )
    
    assert @case_class.methods.include?( :_should )
    assert @case_class.methods.include?( :_context )
    # assert @case.methods.include?( :in_test_mode? )
    
    yield if block_given?
  end
  
  def must_flunk( &block )
    assert_raises( Minitest::Assertion ) do
      if block_given?
        yield
      end
    end
  end
  
  def yep( *args, &block )
    assert @case.send( @current_method_sym, *args, &block )
  end

  def nope( *args, &block )
    must_flunk do
      @case.send( @current_method_sym, *args, &block )
      
      # shouldn't get here
      puts "should fail: #{@current_method_sym}( #{ args.map(&:inspect).join(", ")})"
    end
  end
  
  def oops( *args )
    assert_raises( StandardError ) do
      @case.send( @current_method_sym, *args, &block )
      
      # should not get here
      puts "should cause error: #{@current_method_sym}( #{ args.map(&:inspect).join(", ")})"
    end
  end
  
  def testing_method( m, &block )
    @current_method_sym = m
    yield
  end
end

