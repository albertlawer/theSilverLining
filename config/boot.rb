ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require 'rails/commands/server'
module Rails
  class Server
    def default_options
      super.merge(Port: 4000 )# (Host: '184.173.139.74', Port: 4000)
    end
  end
end

