source "http://rubygems.org"

# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  # gem "shoulda", "~> 3", ">= 3.5"
  # gem "rdoc", "~> 3.12"
  # gem "bundler", "~> 1.0"
  # gem "rcov", ">= 0"
  # gem 'debugger', "~> 1.6"
  # gem 'minitest'
  # gem "fun_with_testing", "~> 0.0", ">= 0.0.4"
end

# 3.6.0  => 2019-10   # most of its functionality is is shoulda-context and shoulda-matchers, which are more up to date
# 2020-06 # removing it seems to be causing problems.  Which only started showing up now?  
gem "shoulda",   "~> 4" 
gem "shoulda-matchers"
gem "shoulda-context"
gem "rdoc",      "~> 6" # 6.2.0  => 2017-02-24
gem "bundler", "~> 2"    # (seems RVM comes with its own version of Bundler that's taking precedence, no idea how to fix)                         # 2.0.2  => 2019-10

gem "juwelier",  "~> 2" # 2.4.9  => 2019-10
gem "simplecov", "~> 0" # 0.17.1 => 2019-10
gem 'byebug',    "~> 10" # 9.0.6  => 2016-09-30
gem 'minitest',  "~> 5" # 5.10.2 => 2017-05-09

# making some of the dependencies more specific than the previously listed gems demand
# okay, Past Bryce.  Thanks for telling me you did that.  But screw you for not trying to explain why.
# gem 'json', "~> 2", ">= 2.0.3"
gem 'nokogiri', ">= 1.8"