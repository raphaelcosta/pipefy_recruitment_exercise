class ApplicationController < ActionController::Base

  require "./lib/api/communicator.rb"
  require "./lib/api/updater.rb"

  protect_from_forgery with: :exception
end
