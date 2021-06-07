# A namespace module that acts as an umbrella for a 
# collection of gems I'm maintaining. (rdoc)
#
# I seem to be trying to write an entire ecosystem
# single-handed.  It's not going well.
module FunWith
  
  # A gem that adds a collection of custom assertions to a test suite.
  #
  # Also includes some infrastructure for testing the assertions themselves.
  #
  # Other FunWith- gems will contain extensions with their own custom assertions.
  # For example, FunWith::Files adds in things like `assert_directory()`, etc.
  module Testing
    
    # Modules full of custom assertions should go under this namespace.
    module Assertions
      module Basics
        # Interesting thing about message() : returns a proc that, when called, returns
        # the message string.  I don't quite understand why it's done that way, but
        # to add a line to an existing msg proc, do `msg = message(msg){"line to add..."}`
        
        def assert_not_zero( actual, msg = nil )
          msg = message(msg) { "Expected #{mu_pp(actual)} to not be zero" }
          assert actual != 0, msg
        end
        
        alias :refute_zero :assert_not_zero
        
        def assert_zero( actual, msg = nil )
          msg = message(msg) { "should be zero, not <#{mu_pp(actual)}>" }
          assert actual == 0, msg
        end

        def assert_one( actual, msg = nil )
          msg = message(msg) { "should be 1, not <#{mu_pp(actual)}>" }
          assert actual == 1, msg
        end
        
        def assert_not_one( actual, msg = nil )
          msg = message(msg) { "should be 1, not <#{mu_pp(actual)}>" }
          assert actual != 1, msg
        end
        
        alias :refute_one :assert_not_one
        
        def assert_negative( actual, msg = nil )
          msg = message(msg) { "should be negative, not <#{mu_pp(actual)}>" }
          assert actual < 0, msg
        end

        def assert_not_negative( actual, msg = nil )
          msg = message(msg) { "should NOT be negative, (actual) <#{mu_pp(actual)}>" }
          assert actual >= 0, msg
        end
        
        alias :refute_negative :assert_not_negative

        def assert_positive( actual, msg = nil )
          msg = message(msg) { "should be positive, not <#{mu_pp(actual)}>" }
          assert actual > 0, msg
        end

        def assert_not_positive( actual, msg = nil )
          msg = message(msg) { "should NOT be positive, (actual) <#{mu_pp(actual)}>" }
          assert actual <= 0, msg
        end
        
        alias :refute_positive :assert_not_positive

        def assert_true( actual, msg = nil )
          msg = message(msg) { "should be true (TrueClass), not <#{mu_pp(actual)}>" }
          assert actual == true, msg
        end

        def refute_true( actual, msg = nil )
          msg = message(msg) { "shouldn't be true (TrueClass)" }
          assert actual != true, msg
        end
        
        # rejects anything but an actual false, instance of the FalseClass
        def assert_false( actual, msg = nil )
          msg = message(msg) { "should be false (instance of FalseClass), not <#{mu_pp(actual)}>" }
          assert actual == false, msg
        end

        def refute_false( actual, msg = nil )
          msg = message(msg) { "shouldn't be false" }
          assert actual != false, msg
        end
        
        def assert_nil( actual, msg = nil )
          msg = message(msg) { "should be nil, not <#{mu_pp(actual)}>" }
          assert actual == nil, msg
        end
        
        def assert_not_nil( actual, msg = nil )
          msg = message(msg) { "should not be nil" }
          assert actual != nil, msg
        end
        
        alias :refute_nil :assert_not_nil
        
        def assert_responds_to_blank( obj, message = nil )
          msg = message(msg){
            "<#{mu_pp(obj)}> does not respond to :blank? or :fwf_blank? methods."
          }
          
          assert obj.respond_to?(:blank?) || obj.respond_to?( :fwf_blank? ), msg
        end
        
        def assert_blank( obj, msg = nil )
          assert_responds_to_blank( obj )
          
          msg = message(msg) { "#{mu_pp(obj)} should be blank." }
          
          assert( (obj.respond_to?(:blank?) && obj.blank?) || (obj.respond_to?(:fwf_blank?) && obj.fwf_blank?), msg )
        end

        def assert_matches( string, regexp_or_string, msg = nil)
          msg = message(msg) { "<#{mu_pp(string)}> should match regex <#{mu_pp(regexp_or_string)}>" }
        
          if regexp_or_string.is_a?(Regexp)
            assert string.match(regexp_or_string), msg
          elsif regexp_or_string.is_a?(String)
            assert string.include?(regexp_or_string), msg
          else
            raise ArgumentError.new( "assert_matches takes a regular expression or string as second argument, not #{regexp_or_string}(#{regexp_or_string.class})")
          end
          
          true   
        end

        def assert_doesnt_match( string, regexp_or_string, msg = nil)
          msg = message(msg) { "<#{mu_pp(string)}> should NOT match string/regex <#{mu_pp(regexp_or_string)}>" }
          
          if regexp_or_string.is_a?(Regexp)
            assert_nil string.match(regexp_or_string), msg
          elsif regexp_or_string.is_a?(String)
            refute string.include?(regexp_or_string), msg
          else
            raise ArgumentError.new( "assert_doesnt_match takes a regular expression or string as second argument, not #{regexp_or_string}(#{regexp_or_string.class})")
          end
          
          true
        end
        
        alias :refute_matches :assert_doesnt_match

        
        def assert_greater_than( reference_value, amount, msg = nil )
          msg = message(msg){
            "second argument <#{mu_pp(amount)}> should be greater than reference value <#{mu_pp(reference_value)}>"
          }

          assert amount > reference_value, msg
        end

        # read as "assert less than 5, <test value>"
        def assert_less_than( reference_value, amount, msg = nil )
          msg = message(msg){ 
            "second argument <#{mu_pp(amount)} should be less than reference value <#{mu_pp(reference_value)}>" 
          }

          assert amount < reference_value, msg
        end

        def assert_at_least( reference_value, amount, msg = nil )
          msg = message(msg) { "Value must be at least #{reference_value}. #{mu_pp(amount)} is too small." }
          
          assert( amount >= reference_value, msg )
        end
        
        def assert_at_most( reference_value, amount, msg = nil )
          msg = message(msg) { "Value can be at most #{reference_value}. #{mu_pp(amount)} is too large." }
          
          assert( amount <= reference_value, msg )
        end
        
        # I think "assert_delta_in_range" already does this for floats
        def assert_times_are_close( t1, t2, window = 1, msg = nil)
          msg = message(msg) { "times should be within #{mu_pp(window)} second of each other." }
          assert (t1 - t2).abs <= window
        end

        def assert_equal_length( expected, actual, msg = nil )
          assert_respond_to expected, :length, message(nil){ "#{mu_pp(expected)} (expected value) doesn't respond to length()." }
          assert_respond_to actual, :length, message(nil){ "#{mu_pp(actual)} (actual value) doesn't respond to length()." }
          
          msg = message(msg){ 
            "items should be of equal length: expected length: <#{mu_pp(expected.length)}>, actual length: <#{mu_pp(actual.length)}>"
          }
          
          assert_equal expected.length, actual.length, msg
        end
        
        def assert_unequal_length( expected, actual, msg = nil )
          msg = message(msg){ 
            "items should be of equal length: expected: <#{mu_pp(expected.length)}>, actual: <#{mu_pp(actual.length)}>"
          }
          
          assert_respond_to expected, :length, message(nil){ "#{mu_pp(expected)} (expected value) doesn't respond to length()." }
          assert_respond_to actual, :length, message(nil){ "#{mu_pp(actual)} (actual value) doesn't respond to length()." }
          
          assert_equal expected.length, actual.length, message
        end
        
        alias :refute_equal_length :assert_unequal_length
        
        
        # `expected` can be a numeric range 
        def assert_length( expected, actual, msg = nil )
          
          no_response_msg = message(nil){ "<#{mu_pp(actual)}> doesn't respond to .length()" }
          
          assert_respond_to actual, :length, no_response_msg
          
          case expected
          when Range
            msg = message(msg){ 
              "<#{mu_pp(actual)}> has a length of #{mu_pp(actual.length)}. Length must be between <#{mu_pp(expected.min)}> and <#{mu_pp(expected.max)}>"
            }
            
            assert_at_least expected.min, actual.length, msg
            assert_at_most  expected.max, actual.length, msg
          when Integer
            msg = message(msg){ "<#{mu_pp(actual)}> has a length of <#{mu_pp(actual.length)}>. Expected length was <#{mu_pp(expected)}>" }
            assert_equal( expected, actual.length, msg )
          else
            flunk( "Bad reference value (first argument: #{expected.inspect}) to assert_length" )
          end
        end
        
        # Tries the given methods on both objects, reports on differing results
        # Doesn't take a custom message.  Methods given must take zero arguments.
        def assert_equality_of_methods( expected, actual, *methods )
          failed = false
          
          results_msg = {}
          results_msg[:expected] = "The following methods were not equal: \nExpected: #{mu_pp(expected)}"
          results_msg[:actual]   = "\n--------------------\nActual: #{mu_pp(actual)}"
          
          
          for method in methods
            no_error_on_method = true
            responses = {}
            
            for obj, response_sym in [[expected, :expected], [actual, :actual]]
              responses[response_sym] = begin
                                          obj.send( method )
                                        rescue StandardError => e
                                          e
                                        end
                                        
              if responses[response_sym].is_a?( StandardError )
                failed = true
                no_error_on_method = false
                results_msg[response_sym] << "\n\t#{method}(): ERROR: #{responses[response_sym].class} #{responses[response_sym].message}"
              end
            end
            
            if responses[:expected] != responses[:actual] && no_error_on_method
              failed = true
              
              for response_sym in [:expected, :actual]
                results_msg[response_sym] << "\n\t#{method}(): #{responses[response_sym].inspect}"
              end
            end
          end
            
          
          assert !failed, results_msg[:expected] + results_msg[:actual]
        end
        
        def assert_has_instance_method( object, instance_method, msg = nil )
          msg = message(msg){ "object #{mu_pp(object)} should respond to #{instance_method.inspect}" }
          assert object.instance_methods.include?( instance_method ), msg
        end
        
        def assert_nothing_raised( msg = nil, &block )
          begin 
            yield if block_given?
            assert true
          rescue Exception => e
            msg = message(msg){ "block should not raise a #{mu_pp(e.class)} (message: #{e.message})"}
            assert false, msg
          end
        end
        
        def assert_constant_defined( const, msg = nil )
          begin
            Object.const_get( const )
            assert true
          rescue NameError
            assert false, message(msg){ "expected constant is not defined: #{const}" }
          end
        end
        
        # Which order makes more sense for the arguments
        # Assert that the first argument includes the module specified in the second argument
        def assert_includes_module( mod_or_class, mod, msg = nil )
          # Make sure we've been passed the proper sort of objects
          assert mod_or_class.respond_to?( :included_modules, "#{mod_or_class} doesn't respond to included_modules()" )
          raise ArgumentError.new( "#{mod} is not a module" ) unless mod.kind_of?( Module )

          msg = message(msg){ "#{mod_or_class} should have included module #{mod}" }
          
          assert mod_or_class.included_modules.include?(mod), msg
        end
      end
    end
  end
end