require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module PipefyRecruitmentExercise
  class Application < Rails::Application
		config.autoload_paths << "#{Rails.root}/lib"
  end
end
