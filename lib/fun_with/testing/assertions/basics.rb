module FunWith
  module Testing
    module Assertions
      module Basics
        def assert_not_zero( actual, message = "" )
          message = build_message(message, "should not be zero")

          assert_block message do
            actual != 0
          end
        end

        def assert_zero( actual, message = "" )
          message = build_message(message, "should be zero, not <#{actual}>")

          assert_block message do
            actual == 0
          end
        end

        def assert_one( actual, message = "" )
          message = build_message(message, "should be 1, not <#{actual}>")

          assert_block message do
            actual == 1
          end
        end
        
        def assert_negative( actual, message = "" )
          message = build_message(message, "should be negative, not <#{actual}>")

          assert_block message do
            actual < 0
          end
        end

        def assert_true( actual, message = "" )
          message = build_message(message, "should be true, not <#{actual}>")
          assert_block message do
            actual == true
          end
        end

        def assert_false( actual, message = "" )
          message = build_message(message, "should be false, not <#{actual}>")
          assert_block message do
            actual == false
          end
        end
        
        
        def assert_blank( obj, message = "" )
          if obj.respond_to?(:blank?)
            full_message = build_message(message, "<?> should be blank.", obj)
          else
            full_message = build_message(message, "<?> does not respond to :blank? method.", obj)
          end 
          
          assert_block full_message do
            obj.respond_to?(:blank?) && obj.blank?
          end
        end

        def assert_matches( string, regexp_or_string, message = "")
          full_message = build_message(message, "<?> should match regex <?>", string, regexp_or_string)
          assert_block full_message do
            if regexp_or_string.is_a?(Regexp)
              string.match(regexp_or_string) ? true : false
            elsif regexp_or_string.is_a?(String)
              string.include?(regexp_or_string)
            end
          end
        end

        def assert_doesnt_match( string, regexp, message = "")
          full_message = build_message(message, "<?> should not match regex <?>", string, regexp)
          assert_block full_message do
            string.match(regexp) ? false : true
          end
        end


        # check that the given variables were assigned non-nil values
        # by the controller

        # If successful, returns an array of assigned objects.
        # You can do:
        # account, phone_number = assert_assigns(:account, :phone_number)
        # or
        # order = assert_assigns(:order)
        def assert_assigns(*args)
          symbols_assigned = []
          symbols_not_assigned = []

          for sym in args
            ((assigns(sym) != nil)? symbols_assigned : symbols_not_assigned) << sym
          end

          message = build_message("", "The following variables should have been assigned values by the controller: <?>", symbols_not_assigned.map{|s| "@#{s.to_s}"}.join(", "))

          assert_block message do
            symbols_not_assigned.length == 0
          end

          if symbols_assigned.length == 1
            assigns(symbols_assigned.first)
          else
            symbols_assigned.map{|s| assigns(s)}
          end
        end

        # Ick
        # read as "assert greater than 5, <test_value>"
        def assert_greater_than( reference_value, amount, message = "" )
          message = build_message("", "second argument <?> should be greater than reference value <?>", amount, reference_value)

          assert_block message do
            amount > reference_value
          end
        end

        # read as "assert less than 5, <test value>"
        def assert_less_than( reference_value, amount, message = "" )
          message = build_message("", "second argument <?> should be less than reference value <?>", amount, reference_value)

          assert_block message do
            amount < reference_value
          end
        end

        # I think "assert_delta_in_range" already does this
        def assert_times_are_close( t1, t2, window = 1, message = "")
          message = build_message(message, "times should be within ? second of each other.", window)

          assert_block message do
            (t1 - t2).abs < window
          end
        end

        def assert_equal_length( expected, actual, message = "" )
          message = build_message( message, "items should be of equal length: expected: <?>, actual: <?>", expected.length, actual.length )
          
          assert_block message do
            expected.length == actual.length
          end
        end
          
        def assert_equality_of_methods(*args)
          expected = args[0]
          actual = args[1]
          methods = args[2..-1].flatten
          message = "The following methods were not equal: "

          unequal = []

          for method in methods
            exp = expected.send(method.to_sym)
            act = actual.send(method.to_sym)
            unless exp == act
              unequal << method
              message += "\n\t#{method} (#{exp.inspect},#{act.inspect})"
            end
          end

          assert_block message do
            unequal.blank?
          end
        end
        
        def assert_has_instance_method( object, instance_method, message = "object #{object} should respond to #{instance_method.inspect}" )
          assert_block( message ) do
            object.instance_methods.include?( instance_method )
          end
        end
      end
    end
  end
end