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
      
      # assumes the gem has a test/factories folder, just requir's everything
      # from that directory.  
      def add_factorybot_support
        unless defined?( FactoryBot )
          begin
            require 'factory_bot'
          rescue LoadError
            puts "Error: FactoryBot support requested, but FactoryBot could not be loaded.  make sure the factory_bot gem is listed in your Gemfile, then run `bundle install`."
          end
        end
        
        FactoryBot.find_definitions if defined?( FactoryBot )   # loads factories, test/factories, and spec/factories if they exist (directory or .rb file) 
      end

      # Convenience methods for disappearing a set of tests.  Useful for focusing on one or two tests.  
      def _context(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST SET #{args.inspect}. Remove leading _ from '_context()' to reactivate."
      end

      def _should(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST #{args.inspect}. Remove leading _ from '_should()' to reactivate."
      end
      
      def _test(*args, &block)
        puts "<<< WARNING >>> IGNORING TEST #{args.inspect}. Remove leading _ from '_test()' to reactivate."
      end
      # def build_message( *args )
      #   args.map(&:inspect).join("  ")
      # end
    end
  end
end