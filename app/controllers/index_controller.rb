class IndexController < ApplicationController
  
  USER_API  = 'pipefydevrecruitingfakeuser@mailinator.com'
  TOKEN_API = 'piBag2uUBesD6X1q78FR'

  def index
  	@organization = Organization.first
    @pipes = @organization.try(:pipes)
  end

  def fetch_new_data
  	API::Updater.new(USER_API, TOKEN_API).update!
  	redirect_to action: :index
  end
end
