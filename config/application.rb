require_relative 'boot'
require 'rails/all'
# require './lib/api/updater'
# require './lib/api/communicator'

Bundler.require(*Rails.groups)

module PipefyRecruitmentExercise
  class Application < Rails::Application
		# config.autoload_paths << "#{Rails.root}/lib"
    # config.autoload_paths += %W( #{config.root}/lib )
    config.autoload_paths   += %W( #{config.root}/lib)
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
