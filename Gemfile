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

ruby_major, ruby_minor, ruby_patch = RUBY_VERSION.split(".").map(&:to_i)

if ruby_major < 2 || ruby_minor < 2 || ruby_minor == 2 && ruby_patch <= 1
  gem "rack", "~> 1"
else
  gem "rack", "~> 2"
end

gem "shoulda",   "~> 3", ">= 3.5"
gem "rdoc",      "~> 4", ">= 4.2.2"
gem "bundler",   "~> 1", ">= 1.10"
gem "juwelier",  "~> 2", ">= 2.1"
gem "simplecov", "~> 0", ">= 0.11"
gem 'byebug',    "~> 9", ">= 9.0"
gem 'minitest',  "~> 5", ">= 5.9"
