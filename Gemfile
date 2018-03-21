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

# Bundler keeps trying to install rack 2,
# failing because it requires Ruby 2.2 or higher

# ruby_major, ruby_minor, ruby_patch = RUBY_VERSION.split(".").map(&:to_i)
#
# if ruby_major < 2 || ruby_minor < 2 || ruby_minor == 2 && ruby_patch <= 1
#   gem "rack", "~> 1"
# else
#   gem "rack", "~> 2"
# end

gem "shoulda",   "~> 3" # 3.5.0  => 2013-05-07   # most of its functionality is is shoulda-context and shoulda-matchers, which are more up to date
gem "rdoc",      "~> 5" # 5.1.0  => 2017-02-24
gem "bundler",   "~> 1" # 1.15.0 => 2017-05-19
gem "juwelier",  "~> 2" # 2.4.5  => 2017-03-14
gem "simplecov", "~> 0" # 0.14.1 => 2017-03-18
gem 'byebug',    "~> 9" # 9.0.6  => 2016-09-30
gem 'minitest',  "~> 5" # 5.10.2 => 2017-05-09

# making some of the dependencies more specific than the previously listed gems demand
# okay, Past Bryce.  Thanks for telling me you did that.  But screw you for not trying to explain why.
# gem 'json', "~> 2", ">= 2.0.3"
gem 'nokogiri', ">= 1.7"