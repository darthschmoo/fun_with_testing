module FunWith
  module Testing
    module TestCaseExtensions
      def install_verbosity
        include VerbosityMethods
      end

      def install_test_mode
        include TestModeMethods
      end

      def install_basic_assertions
        include Assertions::Basics
      end

      # Convenience methods for disappearing a set of tests.  Useful for focusing on one or two tests.  
      def _context(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST SET #{args.inspect}. Remove leading _ from '_context()' to reactivate."
      end

      def _should(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST #{args.inspect}. Remove leading _ from '_should()' to reactivate."
      end
      # def build_message( *args )
      #   args.map(&:inspect).join("  ")
      # end
    end
  end
end