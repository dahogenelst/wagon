source 'https://rubygems.org'

# Specify your gem's dependencies in locomotivecms_wagon.gemspec

gem 'locomotivecms_common', github: 'dahogenelst/common', branch: 'master'
gem 'locomotivecms_coal',   github: 'dahogenelst/coal',   branch: 'master'
gem 'locomotivecms_steam',  github: 'dahogenelst/steam',  branch: 'master'
gemspec

# Mac OS X

# Unix


# Windows
gem 'wdm', '~> 0.1', platforms: :windows # rb-fsevent and rb-inotify come with listen

# Development
# gem 'locomotivecms_common', github: 'locomotivecms/common', ref: '054505c' , require: false
# gem 'locomotivecms_coal',   github: 'locomotivecms/coal',   ref: '3c5f8f8', require: false
# gem 'locomotivecms_steam',  github: 'locomotivecms/steam',  ref: '67c0de7b4e', require: false
# gem 'duktape', github: 'judofyr/duktape.rb', ref: '20ef6a5'

# Local development
# gem 'locomotivecms_coal', path: '../coal', require: false
# gem 'locomotivecms_steam', path: '../steam', require: false
# gem 'locomotivecms_common', path: '../common', require: false

group :development, :test do
  gem 'pry-byebug',         '~> 3.10'
end

group :test do
  gem 'rspec',              '~> 3.13'
  gem 'json_spec',          '~> 1.1'
  gem 'vcr',                '~> 6.2'

  # gem 'codeclimate-test-reporter',  '~> 1.0',  require: false
  # gem 'coveralls',                  '~> 0.8', require: false
  gem 'simplecov',          require: false
end
