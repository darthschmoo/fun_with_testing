module FunWith
  module Testing
    class TestCase < Minitest::Test
      # I may eventually decide that there's a reason to specify which
      # gem is being tested, but this really wasn't it.
      # 
      # Okay, that was stupid.  The point was to allow verbosity to be specified in the gem's code,
      # not just in the test suite.  What would that be... MyGem.test_mode?  MyGem.verbose_gem?  MyGem.say
      def self.gem_to_test( gem_const = nil, test_mode = true )
        if @fwt_gem_to_test
          return @fwt_gem_to_test
        elsif self.superclass.respond_to?( :gem_to_test )
          self.superclass.gem_to_test
        else
          nil
        end
      end

      def self.gem_to_test=( gem_const )
        @fwt_gem_to_test = gem_const
      end
      
      def self.set_test_mode( mode = true )
        self.const_set( :FWT_TEST_MODE, mode )
      end

      # Originally named test_mode?(), but Test::Unit::TestCase picked up on the fact that it started with "test"
      # and tried to run it as a test in its own right
      def self.in_test_mode?
        return self::FWT_TEST_MODE if self.constants.include?( :FWT_TEST_MODE )
        return self.superclass.in_test_mode? if self.superclass.respond_to?(:in_test_mode?)
        return false
      end

      def in_test_mode?
        self.class.in_test_mode?
      end
      
      def self.set_verbose( mode = true )
        self.const_set( :FWT_TEST_VERBOSITY, mode )
      end
      
      def self.verbose?
        return self::FWT_TEST_VERBOSITY if self.constants.include?( :FWT_TEST_VERBOSITY )
        return self.superclass.verbose? if self.superclass.respond_to?(:verbose)
        return false
      end

      def verbose?
        self.class.verbose?
      end
      
      def puts_if_verbose( msg, stream = $stdout )
        stream.puts( msg ) if self.verbose?
      end
      
      # Convenience methods for disappearing a set of tests.  Useful for focusing on one or two tests.  
      def self._context(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST SET #{args.inspect}. Remove leading _ from '_context()' to reactivate."
      end

      def self._should(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST #{args.inspect}. Remove leading _ from '_should()' to reactivate."
      end
      
      def test_gem_validity
        if jem = self.class.gem_to_test
          assert_equal [], jem.validate_gem
        end
      end
      
      def build_message( *args )
        args.map(&:inspect).join("  ")
      end
    end
  end
end