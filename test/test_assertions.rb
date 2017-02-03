require 'helper'

module FunWith
  module Testing
    class TestAssertions < FunWith::Testing::MyTestCase
      def modded_object( &block )
        m = Module.new(&block)
        o = Object.new
        o.extend( m )
        o
      end
      
      context "testing assertions" do
        setup do
          extended_test_case  # sets @case, which is used to access to assertions
          @case_class.install_basic_assertions # send( :include, FunWith::Testing::Assertions::Basics )
        end
        
        context "testing :assert_zero()" do
          should "accept only zeroes, reject all others" do
            testing_method :assert_zero do
              yep  0
              yep  0.0
              
              nope 1
              nope :potato
            end
            
            testing_method :refute_zero do
              yep  1
              yep  0.4
              yep( -1 )
              yep  :zero
              yep  "0"
              yep  "zero"
              yep  ""
              
              nope 0
              nope "0".to_i
              nope "0".to_f
            end
          end
        end
        
        
        context "testing :assert_not_zero()" do
          should "look for non-zeros everywhere" do
            testing_method :assert_not_zero do
              yep  1
              yep( -1 )
              yep  0.01
              yep( -0.01 )
              yep  :zero
              yep  []
              yep( {} )
              yep  ""
              yep  nil
              nope 0
            end
          end
        end
        
        context "testing :assert_one()" do
          should "pass all tests" do
            testing_method :assert_one do
              yep  1
              yep  1.0
              yep  1.to_c   # comparison as a complex number
              nope 2
              nope( -3 )
              nope []
              nope( {} )
            end
          end
        end

        context "testing :refute_one()" do
          should "pass all tests" do
            testing_method :refute_one do
              yep  2
              yep( -3 )
              yep  []
              yep( {} )
              nope 1
              nope 1.0
              nope 1.to_c   # comparison as a complex number
            end
          end
        end

        context "testing :assert_positive()" do
          should "pass all tests" do
            testing_method :assert_positive do
              yep  1
              yep  1000
              yep  1000.0
              yep  0.0000000000001
              yep  5
              yep  4
              yep  0.00001
              yep  Math::PI
              yep  1337
              yep  91

              nope 0
              nope( -0.00001 )
              nope( -50 )
              nope( -5000 )
              nope( -50000 )
              nope 0
              nope( -0.000000000001 )
              nope( -1 )
              nope( -1000 )
              nope( -1000000 )
            
              oops true
              oops false
              oops 10000.to_c
              oops "3"
              oops( {} )
              oops []
              oops :symbol           
            end 
          end
        end

        context "testing :refute_positive()" do
          should "pass all tests" do
            testing_method :refute_positive do
              yep  0
              yep  0.0
              yep( -1 )
              yep( -100 )
              yep(  -0.000000000001 )
              yep( -1 )
              yep( -1000 )
              yep( -1000000 )
            
              nope 1
              nope 1000
              nope 1000.0
              nope 0.0000000000001
              nope 0.0001
              nope 1
              nope 5
              nope 99999999999999
            
              oops []
              oops nil
              oops 5.to_c
              oops 10000.to_c
              oops true
              oops false
            end
          end
        end
        
        context "testing :assert_true()" do
          should "pass all tests" do
            testing_method :assert_true do
              yep  true
            
              nope false
              nope nil
              nope 5
              nope "string"
              nope :symbol
              nope []
              nope Hash.new
            end
          end
        end

        context "testing :assert_false()" do
          should "pass all tests" do
            testing_method :assert_false do
              yep  false
            
              nope true
              nope nil
              nope 5
              nope "string"
              nope :symbol
              nope []
              nope Hash.new
            end
          end
        end

        context "testing :refute_true()" do
          should "pass all tests" do
            testing_method :refute_true do
              yep  false
              yep  nil
              yep  5
              yep  "string"
              yep  :symbol
              yep  []
              yep  Hash.new
          
              nope true
            end
          end
        end

        context "testing :refute_false()" do
          should "pass all tests" do
            testing_method :refute_false do
              yep  true
              yep  nil
              yep  5
              yep  "string"
              yep  :symbol
              yep  []
              yep  Hash.new

              nope false
            end
          end
        end
        
        context "testing :assert_nil()" do
          should "pass all tests" do
            testing_method :assert_nil do
              yep  nil
            
              nope true
              nope false
              nope 5
              nope "string"
              nope :symbol
              nope []
              nope Hash.new
            end
          end
        end
        
        context "testing :refute_nil()" do
          should "pass all tests" do
            testing_method :refute_nil do
              yep  true
              yep  false
              yep  5
              yep  "string"
              yep  :symbol
              yep  []
              yep  Hash.new  # if not given parentheses, seen as a block not a hash.

              nope nil
            end
          end
        end
        
        context "testing :assert_blank()" do
          should "pass all tests" do
            
            blank_obj = modded_object do
              def blank?
                true
              end
            end

            fwfblank_obj = modded_object do
              def fwf_blank?
                true
              end
            end
            
            not_blank_obj = modded_object do
              def blank?
                false
              end
            end
            
            blank_error_obj = modded_object do
              def fwf_blank?
                raise StandardError.new("Raises error!")
              end
            end
            
            blank_returns_5_obj = modded_object do
              def fwf_blank?
                5
              end
            end
            
            testing_method :assert_responds_to_blank do
              nope []
              nope( {} )
              nope ""
              nope Object.new
              nope Set.new

              yep  blank_obj
              yep  fwfblank_obj
              yep  not_blank_obj
              yep  blank_error_obj
              yep  blank_returns_5_obj
            end
            
            testing_method :assert_blank do
              # As implemented, assert_blank first asserts the item responds to blank, causing its own error
              nope []
              nope( {} )
              nope Set.new
              nope ""

              yep  blank_obj
              yep  fwfblank_obj
            
              nope not_blank_obj
            
              oops blank_error_obj
            end
          end
        end

        context "testing :assert_matches()" do
          should "pass all tests" do
            testing_method :assert_matches do
              yep  "Why hello there!", /hello/
              nope "Why HELLO there!", /hello/
              yep  "Why HELLO there!", /hello/i
            
              yep  "Why HELLO there!", "HELLO"
              nope "Why HELLO there!", "hello"
            
              oops 5, /oopsie/
              oops "oops", :symbol
            end
          end
        end
        
        context "testing :refute_matches()" do
          should "pass all tests" do
            testing_method :refute_matches do
              nope "Why hello there!", /hello/
              yep  "Why HELLO there!", /hello/
              nope "Why HELLO there!", /hello/i
            
              nope "Why HELLO there!", "HELLO"
              yep  "Why HELLO there!", "hello"
            
              oops 5, /oopsie/
              oops "oops", :symbol
            end
          end
        end
        
        context "testing :assert_greater_than()" do
          should "pass all tests" do
            testing_method :assert_greater_than do
              yep  5, 5.1
              yep( -4, -3 )
              yep  "a", "b"
              nope 0, 0
              nope 0, 0.0
              nope 5.1, 5.0
              nope( -4, -5 )
            
              oops 5, nil
              oops 6, []
            end
          end
        end
        
        context "testing :assert_less_than()" do
          should "pass all tests" do
            testing_method( :assert_less_than ) do
              yep  5, 4
              yep  "b", "a"
              yep  100, 7.1
              yep  0.0, -1
              yep  0.999, 0.998
            
              nope 0, 0
              nope 0.0, 0
              nope "a", "a"
              nope( -1000, -100 )
              nope 5, 6
            
              oops 1000, "a"
              oops "a", nil
            end
          end
        end
        
        context "testing :assert_at_most()" do
          should "pass all tests" do
            testing_method :assert_at_most do
              yep  0, 0
              yep  0, 0.0
              yep  0.0, 0.0
              yep  5, 3
              yep  5, 1.4
              
              nope 2, 6
              nope( -12, -4 )
              
              oops 5, []
            end
          end
        end

        context "testing :assert_at_least()" do
          should "pass all tests" do
            testing_method :assert_at_least do
              yep  0, 0
              yep  0, 0.0
              yep  0.0, 0.0
              yep  3, 5
              yep  1.4, 5
              
              nope 6, 2
              nope( -4, -14 )
              
              oops 5, []
            end
          end
        end

        context "testing :assert_times_are_close()" do
          should "pass all tests" do
            @ref_time = Time.now
            
            testing_method( :assert_times_are_close ) do
              yep  @ref_time, @ref_time + 1
              yep  @ref_time, @ref_time + 0.3
              yep  @ref_time, @ref_time
              yep  @ref_time, @ref_time - 5, 20    # 20-second window given
            
              nope @ref_time, @ref_time + 0.1, 0.01
              nope @ref_time, @ref_time + 1.1
              nope @ref_time, @ref_time - 1.1
              nope @ref_time, @ref_time - 100
              nope @ref_time, @ref_time - 100, 99
            
              oops @ref_time, nil
              oops @ref_time, []
            end
          end
        end
        
        context "testing :assert_equal_length()" do
          should "pass all tests" do
            testing_method( :assert_equal_length ) do
              yep  [], []
              yep  [], {}
              yep  [1,2,3,4,5], { 1 => :one, 2 => :two, 3 => :three, 4 => :four, 5 => :five}
              yep  Set.new, {}
              yep  [1,2,3,4,5], :hello
            
              nope :hello, "goodbye"
              nope [], { 1 => :one }
              nope Set.new( [1,2,3] ), Set.new( [4,5,6,7] )
            end
          end
        end
        
        context "testing :assert_length()" do
          should "pass all tests" do
            testing_method :assert_length do
              yep 0, ""
              yep 0, :""
              yep 1, [ :one ]
              yep 0..5, { 1 => :one, 2 => :two, 3 => :three }
              yep 0..140, "This string is tweetable!"
              yep 1..3, "two" 
              yep 4, "four"
            
              nope 0, "hi"
              nope 0, [ 1 ]
              nope 5, "five"
              nope 1..3, [1, 2, 3, 4]
              nope 3..5, nil
            end
          end
        end

        context "testing :assert_equality_of_methods()" do
          should "pass all tests" do
            testing_method :assert_equality_of_methods do
              yep  7, 7, :to_s, :hash, :to_f
              nope 3, 4, :to_s, :hash, :to_f
              nope [], {}, :last    # hash doesn't respond to last
              nope 3, 4, :times
              nope 3, 4, :respond_to?  # ArgumentError for both
            end
          end
        end
        
        context "testing :assert_nothing_raised()" do
          should "pass all tests" do
            testing_method :assert_nothing_raised do
              yep do
                5 + 6
              end
              
              yep do
                nil
              end
              
              nope do
                raise StandardError.new( "whoops" )
              end
            end
          end
        end
        
        # context "testing :555()" do
        #   should "pass all tests" do
        #     testing_method : do
        #     yep
        #     yep
        #     yep
        #     yep
        #     yep
        #     yep
        
        #     nope
        #     nope
        #     nope
        #     nope
        #     nope
        #     nope
        
        #     oops
        #   end
        # end
        # context "testing :555()" do
        #   should "pass all tests" do
        #     testing_method : do
        #     yep
        #     yep
        #     yep
        #     yep
        #     yep
        #     yep
        
        #     nope
        #     nope
        #     nope
        #     nope
        #     nope
        #     nope
        
        #     oops
        #   end
        # end

        
        context "testing instance assertions" do
          should "assure us that classes have methods" do
            instance_methods = {
              Integer => [:to_s, :odd?, :even?, :times, :ceil],
              Fixnum  => [:to_f],
              Array   => [:length, :each, :sort, :map],
              Object  => [:hash, :tap, :is_a?, :to_s]
            }
            
            testing_method :assert_has_instance_method do
              for klass, methods in instance_methods
                for method in methods
                  yep klass, method
                end
              end
            end
          end
          
          should "assure us that classes don't have hinkey instance methods" do
            instance_methods = {
              Integer => [:to_p, :old?, :seven?, :timey, :seal],
              Fixnum  => [:to_g],
              Array   => [:lanth, :eech, :sorta, :nap, :way_too_long?],
              Object  => [:hashbrown, :tarp, :is_also_a?, :to_sting]
            }
            
            testing_method :assert_has_instance_method do
              for klass, methods in instance_methods
                for method in methods
                  nope klass, method
                end
              end
            end
          end
        end

        context "testing length assertions" do
          should "acknowledge the zerolengthiness of the empty array" do
            @case.assert_length 0, []
            @case.assert_length 17, %w(my mother told me to pick the very best one and the very best one is you)
            @case.assert_equal_length [], []
          end
        end
      end
    end
  end
end