module FunWith
  module Testing
    # For adding to a TestCase class
    module VerbosityMethods
      def self.included( base )
        base.extend( ClassMethods )
        base.send( :include, InstanceMethods)
      end
      
      module ClassMethods
        def set_verbose( mode = true )
          self.const_set( :FWT_TEST_VERBOSITY, mode )
        end
      
        def verbose?
          return self::FWT_TEST_VERBOSITY if self.constants.include?( :FWT_TEST_VERBOSITY )
          return self.superclass.verbose? if self.superclass.respond_to?(:verbose)
          return false
        end
      end
      
      module InstanceMethods
        def verbose?
          self.class.verbose?
        end
      
        def puts_if_verbose( msg, stream = $stdout )
          stream.puts( msg ) if self.verbose?
        end
      end
    end
  end
end
      


module FunWith
  module Testing
    module VerbosityMethods
      
    end
  end
end
