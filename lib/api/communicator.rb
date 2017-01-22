module API
	class Communicator
		
		include HTTParty
		base_uri 'https://app.pipefy.com/'

		attr_accessor :organization_key, :organization, :pipes

		def initialize(email, token, organization_key = 49232)
			self.organization_key = organization_key
      @options = { query: { user_email: email, user_token: token } }
    end

  	def request!
  		pipes = []
			request_organization['pipes'].each do |pipe|
				pipes << self.class.get("/pipes/#{pipe['id']}.json", @options)
			end
			self.pipes = pipes
  	end
  	
  	private

  	def request_organization
    	self.organization = self.class.get("/organizations/#{organization_key}.json", @options)
  	end
	end
end
