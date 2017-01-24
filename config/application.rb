require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module PipefyRecruitmentExercise
  class Application < Rails::Application
    config.autoload_paths   += %W( #{config.root}/lib) if  ['development', 'test'].include? Rails.env
  end
end
