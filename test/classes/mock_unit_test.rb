module FunWith
  module Testing
    # Any subclass of Test::Unit::TestCase seems to automatically hook into the test suite.
    # Therefore, calling a test to see if it returns false makes the suite fail.  Including
    # to this class instead prevents that.  
    #
    # I may need to more closely mimic Test::Unit::TestCase
    # in order to test messages properly.
    class MockUnitTest < FunWith::Testing::TestCase
      def safe_assert_block( *args, &block )
        yield
      end
    end
  end
end
    