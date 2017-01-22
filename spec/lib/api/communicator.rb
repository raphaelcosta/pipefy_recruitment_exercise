require 'rails_helper'

describe API::Communicator do
	
	before do
		@communicator = API::Communicator.new('pipefydevrecruitingfakeuser@mailinator.com', 'piBag2uUBesD6X1q78FR')
	end
	

	describe :response do

		before { @communicator.request!	}
	
		it 'should show organization' do
			expect(@communicator.organization['id']).to 				eql 49232
			expect(@communicator.organization['name']).to 			be_present
			expect(@communicator.organization['created_at']).to be_present
			expect(@communicator.organization['updated_at']).to be_present
			expect(@communicator.organization['pipes']).to 			be_present
		end

		it 'should return all pipes from organization' do
			expect(@communicator.pipes.first['name']).to  		 be_present
			expect(@communicator.pipes.first['can_edit']).to   be_falsey
			expect(@communicator.pipes.first['created_at']).to be_present
			expect(@communicator.pipes.first['token']).to  		 be_present
			expect(@communicator.pipes.first['users']).to  		 be_present
			expect(@communicator.pipes.first['labels']).to 		 be_present
			expect(@communicator.pipes.first['phases']).to 		 be_present
		end
	end
end
