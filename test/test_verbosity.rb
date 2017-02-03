require 'helper'

module FunWith
  module Testing
    class TestVerbosity < FunWith::Testing::AssertionsTestCase
      context "testing in_test_mode?" do
        setup do 
          extended_test_case
          @case_class.install_verbosity
        end
        
        should "set into verbose by default" do
          @case_class.set_verbose
          assert @case.verbose?
        end
        
        should "explicitly set to false" do
          @case_class.set_verbose( false )
          assert @case.verbose? == false
        end
        
        should "return false when set_verbose() hasn't been called" do
          assert @case.verbose? == false
        end
      end
    end
  end
end