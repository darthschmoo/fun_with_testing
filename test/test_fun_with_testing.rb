require 'helper'


class TestFunWithTesting < FunWith::Testing::MyTestCase
  should "be plumbed properly" do
    assert defined?( FunWith::Testing::Assertions )
    assert defined?( FunWith::Testing::Assertions::Basics )
    
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_blank )
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_blank )
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_greater_than )
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_zero )
  end
  
  should "have test/unit on board" do
    assert( defined?( Minitest ), "problem loading Minitest" )
    assert( defined?( Minitest::Test ), "problem loading Minitest" )
  end
  
  should "access a listing of assertion modules" do
    assert_includes( FunWith::Testing.included_modules, FunWith::Testing::Assertions::Basics )
  end
  
  should "successfully get included in a subclass" do
    klass = Class.new( Minitest::Unit )
    
    imethods = klass.instance_methods.select{|sym| sym.to_s =~ /^(assert|refute)_/ }
    
    refute_includes imethods, :assert_zero
    klass.send( :include, FunWith::Testing )
    imethods = klass.instance_methods.select{|sym| sym.to_s =~ /^(assert|refute)_/ }
    assert_includes( imethods, :assert_zero )
  end
end
