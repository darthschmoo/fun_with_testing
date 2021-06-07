module FunWith
  module Testing
    # Class is designed specifically for testing custom assertions.
    # See test/test_assertions.rb for how it's supposed to work.
    class AssertionsTestCase < FunWith::Testing::TestCase
      def self.fwt_install_mock_safe_assert_block
        include AssertionTestMocker
      end
      
      # After @case_class is created, you can include the methods you want to test
      # 
      def extended_test_case( &block )
        @case_class = Class.new( FunWith::Testing::AssertionsTestCase )
        
        # Unhook from some of the test harness stuff to
        # make it possible to run the assertion methods 
        # without causing the test suite to topple over.
        @case_class.fwt_install_mock_safe_assert_block
        
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
      
      # 
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
    