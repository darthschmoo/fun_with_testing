# require 'test/unit'

files = Dir.glob( File.join( File.dirname(__FILE__), "fun_with", "testing", "**", "*.rb" ) )

for file in files.map{ |f| f.gsub(/\.rb$/, '') }
  require file
end


# FunWith::Testing.extend( FunWith::Testing::FwtExtensions )
# FunWith::Testing.assertion_modules << FunWith::Testing::Assertions::ActiveRecord
# FunWith::Testing.assertion_modules << FunWith::Testing::Assertions::Basics

FunWith::Testing.send(:include, FunWith::Testing::Assertions::Basics)
FunWith::Testing.send(:include, FunWith::Testing::Assertions::ActiveRecord)
