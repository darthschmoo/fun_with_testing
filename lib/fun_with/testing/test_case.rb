module FunWith
  module Testing
    class TestCase < Minitest::Test
      puts "----------------------------------------------- #{__FILE__}-----------------------------------------------"
      extend TestCaseExtensions
    end
  end
end