require 'helper'

module FunWith
  module Testing
    class TestTestMode < FunWith::Testing::MyTestCase
      # TODO:  "test mode" applies to gems, so this whole concept needs to be moved to FW::Gems
      _context "testing in_test_mode?" do
        setup do 
          extended_test_case
          @gem_to_test = Module.new
        end
        
        should "set into test mode by default" do
          @case_class.set_test_mode
          assert @case.in_test_mode?
        end
        
        should "explicitly set to false" do
          @case_class.set_test_mode( false )
          assert @case.in_test_mode? == false
        end
        
        should "return false when no gem is set" do
          assert @case.in_test_mode? == false
        end
      end
    end
  end
end