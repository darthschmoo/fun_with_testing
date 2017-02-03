module FunWith
  module Testing
    # Class is designed specifically for testing custom assertions.
    # See test/test_assertions.rb for how it's supposed to work.
    class AssertionsTestCase < FunWith::Testing::TestCase
      # Any subclass of Test::Unit::TestCase seems to automatically hook into the test suite.
      # Therefore, calling a test to see if it returns false makes the suite fail.  Including
      # to this class instead prevents that.  
      #
      # I may need to more closely mimic Test::Unit::TestCase
      # in order to test messages properly.
      def safe_assert_block( *args, &block )
        yield
      end

      def extended_test_case( &block )
        @case_class = Class.new( FunWith::Testing::AssertionsTestCase )

        @case = @case_class.new( "MockUnitTest" )        # what does name arg do?
    
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
  end
end
    