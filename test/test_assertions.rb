require 'helper'

module FunWith
  module Testing
    class TestAssertions < FunWith::Testing::TestCase
      context "testing :assert_zero()" do
        setup do
          extended_test_case
        end
        
        should "proclaim zero is zero" do
          assert_equal true, @case.assert_zero( 0 )
        end
        
        should "refute the notion that zero is one" do
          assert_equal false, @case.assert_zero( 1 )
        end
        
        should "demonstrate zero is not a potato" do
          assert_equal false, @case.assert_zero( :potato )
        end

        should "prove beyond a shadow of a doubt that zero is not a grue" do
          assert_equal false, @case.assert_zero( "grue" )
        end
        
        # curious why it doesn't have :to_f
        should "acknowledge that Integer has instance_variable to :to_s" do
          assert_equal( true, @case.assert_has_instance_method( Integer, :to_s ) )
        end
      end
    end
  end
end