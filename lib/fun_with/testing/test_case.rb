module FunWith
  module Testing
    class TestCase < Minitest::Test
      def self.install_verbosity
        include VerbosityMethods
      end
      
      def self.install_test_mode
        include TestModeMethods
      end
      
      def self.install_basic_assertions
        include Assertions::Basics
      end
      
      # I may eventually decide that there's a reason to specify which
      # gem is being tested, but this really wasn't it.
      # 
      # Okay, that was stupid.  The point was to allow verbosity to be specified in the gem's code,
      # not just in the test suite.  What would that be... MyGem.test_mode?  MyGem.verbose_gem?  MyGem.say
      def self.gem_to_test( gem_const = nil, test_mode = true )
        @fwt_gem_to_test ||= nil
        
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
      
      # Convenience methods for disappearing a set of tests.  Useful for focusing on one or two tests.  
      def self._context(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST SET #{args.inspect}. Remove leading _ from '_context()' to reactivate."
      end

      def self._should(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST #{args.inspect}. Remove leading _ from '_should()' to reactivate."
      end
      
      # TODO: Should be part of fun_with_gems
      def test_gem_validity
        if jem = self.class.gem_to_test
          assert_equal [], jem.validate_gem
        end
      end
      
      # def build_message( *args )
      #   args.map(&:inspect).join("  ")
      # end
    end
  end
end