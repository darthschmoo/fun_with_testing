module FunWith
  module Testing
    # For adding to a TestCase class
    module TestModeMethods
      def self.included( base )
        base.extend( TestModeMethods::ClassMethods )
        base.send( :include, TestModeMethods::InstanceMethods)
      end
      
      def ClassMethods
        def set_test_mode( mode = true )
          self.const_set( :FWT_TEST_MODE, mode )
        end

        # Originally named test_mode?(), but Test::Unit::TestCase picked up on the fact that it started with "test"
        # and tried to run it as a test in its own right
        def in_test_mode?
          return self::FWT_TEST_MODE if self.constants.include?( :FWT_TEST_MODE )
          return self.superclass.in_test_mode? if self.superclass.respond_to?(:in_test_mode?)
          return false
        end
      end
      
      def InstanceMethods
        def in_test_mode?
          self.class.in_test_mode?
        end
      end
    end
  end
end
      
