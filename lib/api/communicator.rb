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
      self.pipes = request_pipes
    end

    private

    def request_organization
      self.organization = self.class.get("/organizations/#{organization_key}.json", @options)
    end

    def request_pipes
      pipes = []
      request_organization['pipes'].each do |pipe|
        pipes << prepare_pipe(self.class.get("/pipes/#{pipe['id']}.json", @options))
      end

      pipes
    end

    def prepare_pipe(pipe_result)
      pipe_result['phases'].each do |phase|
        phase["cards"].each do |card|
          result = self.class.get("/cards/#{card['id']}.json", @options)
          card['field_values'] = result['current_phase_detail']['field_values']
          phase['fields']      = result['current_phase_detail']['phase']['fields']
        end
      end

      pipe_result
    end
  end
end