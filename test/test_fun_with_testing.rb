require 'helper'


class TestFunWithTesting < FunWith::Testing::TestCase
  should "be plumbed properly" do
    assert defined?( FunWith::Testing::Assertions )
    assert defined?( FunWith::Testing::Assertions::ActiveRecord )
    assert defined?( FunWith::Testing::Assertions::Basics )
    
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_blank )
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_blank )
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_greater_than )
    assert_includes( FunWith::Testing::Assertions::Basics.instance_methods, :assert_zero )
    assert_includes( FunWith::Testing::Assertions::ActiveRecord.instance_methods, :assert_no_errors_on )
  end
  
  should "access a listing of assertion modules" do
    assert_includes( FunWith::Testing.included_modules, FunWith::Testing::Assertions::ActiveRecord )
    assert_includes( FunWith::Testing.included_modules, FunWith::Testing::Assertions::Basics )
  end
  
  should "successfully get included in a subclass" do
    klass = Class.new( Test::Unit::TestCase )
    
    imethods = klass.instance_methods.select{|sym| sym.to_s =~ /^(assert|refute)_/ }
    assert_not_include imethods, :assert_zero
    klass.send( :include, FunWith::Testing )
    imethods = klass.instance_methods.select{|sym| sym.to_s =~ /^(assert|refute)_/ }
    assert_include( imethods, :assert_zero )
  end
end
