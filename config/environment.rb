# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.11' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

#Use for gravatar
require 'digest'

#Use for pagination
#require 'will_paginate'

#Use for log to file
##!/usr/bin/env ruby
#require 'logger'
##use log rotation .To enable log rotation, pass 'monthly', 'weekly', or 'daily' to the Logger constructor. Optionally, you can pass a maximum file size and number of files to to keep in rotation to the constructor.
##log = Logger.new( 'log.txt', 'daily' )
##see config.logger = Logger.new("#{RAILS_ROOT}/log/#{ENV['RAILS_ENV']}ngb.log", 10, 5*1048576)
#log = Logger.new("#{RAILS_ROOT}/log/#{ENV['RAILS_ENV']}ngb.log", 10, 5*1048576)

##Priority message debug, info, warn, error and fatal.
##log.debug "Once the log becomes at least one"
##log.debug "day old, it will be renamed and a"
##log.debug "new log.txt file will be created."
##log.level = Logger::WARN
##log.debug "This will be ignored"
##log.error "This will not be ignored"



Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.autoload_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  # config.gem 'will_paginate', :version => '2.3.12'  #--> Kappao
  # config.gem 'will_paginate', :version => '3.0.1'  --> Kappao
  #config.gem 'will_paginate', :version => '~> 2.3.16'


  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end

#ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
#  :date_time_file  => "%y%m%d%H%M",
#)

#Mime::Type.register "text/csv", :csv
