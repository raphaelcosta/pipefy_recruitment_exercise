require 'rails_helper'

describe API::Updater do
	
	describe :fetching do

		before do
			updater = API::Updater.new('user@fake.com', 'token123')
			updater.stub(:organization).and_return({"id"=>49232,
	   		"name"=>"Pipefy", "created_at"=>"2017-01-18T12:03:08.274-02:00", "updated_at"=>"2017-01-18T12:04:15.321-02:00",
	   		"pipes"=>[{"id"=>143156, "name"=>"Bug Tracking"}, {"id"=>143185, "name"=>"New Developers Recruitment "}]})
			updater.stub(:pipes).and_return([{
				 "id"=>143156, "name"=>"Bug Tracking","created_at"=>"2017-01-18T12:03:21.345-02:00", "updated_at"=>"2017-01-18T12:03:21.998-02:00",
	 			 "token"=>"abcd", "can_edit"=>false,
				 "users"=>[{"id"=>3598, "name"=>"user name", "username"=>"user", "email"=>"user@pipefy.com", "display_username"=>"usuario"},
				 					 {"id"=>3591, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"}],
				 "labels"=> [{"id"=>594180, "name"=>"Blocker", "color"=>"#000000"}],
				 "phases"=>
				  [{"id"=>1065145, "name"=>"Start form", "description"=>'teste', "done"=>false, "pipe_id"=>143156, "index"=>0.0, "draft"=>true,
				    "cards"=>[{"id"=>1605641, "title"=>"Draft", "current_phase_id"=>1065145, "due_date"=>"2017-01-18T12:04:15.321-02:00", "index"=>0.1}]}]}
				])

			updater.stub(:request!).and_return(true)
			updater.update!
			expect(updater).to have_received(:request!)
		end

		it 'should fetch new organization' do
			organization = Organization.find_by_external_id(49232)
			expect(organization.name).to eql 'Pipefy'
		end
	
		it 'should fetch new pipe' do
			pipe = Pipe.find_by_external_id(143156)
			expect(pipe.name).to eql 'Bug Tracking'
			expect(pipe.token).to eql 'abcd'
			expect(pipe.organization_id).to be_present
			expect(pipe.can_edit).to be_falsey
		end

		it 'should fetch new user' do
			user = User.find_by_external_id(3598)
			expect(user.name).to 		 eql 'user name'
			expect(user.username).to eql 'user'
			expect(user.email).to 	 eql 'user@pipefy.com'
			expect(user.display_username).to eql 'usuario'

		end

		it 'should fetch new label' do
			label = Label.find_by_external_id(594180)
			expect(label.name).to eql  'Blocker'
			expect(label.color).to eql '#000000'
		end

		it 'should fetch new phase' do
			phase = Phase.find_by_external_id(1065145)
			expect(phase.name).to 			 eql 'Start form'
			expect(phase.description).to eql 'teste'
			expect(phase.done).to 			 eql false
			expect(phase.pipe_id).to 	   be_present
			expect(phase.index).to 			 eql 0.0
			expect(phase.draft).to 			 eql true
		end

		it 'should fetch new card' do
			card = Card.find_by_external_id(1605641)
			expect(card.title).to 	 eql 'Draft'
			expect(card.index).to 	 eql 0.1
		end
	end

	describe :updating do

		before do
			updater = API::Updater.new('user@fake.com', 'token123')
			updater.stub(:organization).and_return({"id"=>49232,
	   		"name"=>"Pipefy A", "created_at"=>"2017-01-18T12:03:08.274-02:00", "updated_at"=>"2017-01-18T12:04:15.321-02:01",
	   		"pipes"=>[{"id"=>143156, "name"=>"Bug Tracking"}, {"id"=>143185, "name"=>"New Developers Recruitment "}]})
			updater.stub(:pipes).and_return([{
				 "id"=>143156, "name"=>"Bug Tracking","created_at"=>"2017-01-18T12:03:21.345-02:00", "updated_at"=>"2017-01-18T12:03:21.998-02:00",
	 			 "token"=>"abcd", "can_edit"=>true,
				 "users"=>[{"id"=>3598, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"},
				 					 {"id"=>3591, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"}],
				 "labels"=> [{"id"=>594180, "name"=>"Blocker A", "color"=>"#FFFFFF"},{"id"=>594170, "name"=>"Blocker A", "color"=>"#FFFFFF"}],
				 "phases"=>
				  [{"id"=>1065145, "name"=>"Start form A", "description"=>'teste A', "done"=>true, "pipe_id"=>143156, "index"=>0.1, "draft"=>false,
				    "cards"=>[{"id"=>1605641, "title"=>"Draft a", "current_phase_id"=>1065145, "due_date"=>"2017-01-18T12:04:15.321-02:01", "index"=>0.2}]}]}
				])
			updater.stub(:request!).and_return(true)
			updater.update!
			expect(updater).to have_received(:request!)
		end
	
		it 'should update organization' do
			organization = Organization.find_by_external_id(49232)
			expect(organization.name).to eql 'Pipefy A'
		end

		it 'should update pipe' do
			pipe = Pipe.find_by_external_id(143156)
			expect(pipe.name).to 		 eql 'Bug Tracking'
			expect(pipe.token).to 	 eql 'abcd'
			expect(pipe.can_edit).to be_truthy
		end

		it 'should update user' do
			user = User.find_by_external_id(3598)
			expect(user.name).to 		 eql 'user name a'
			expect(user.username).to eql 'user a'
			expect(user.email).to 	 eql 'usera@pipefy.com'
			expect(user.display_username).to eql 'usuario a'

		end

		it 'should update label' do
			label = Label.find_by_external_id(594180)
			expect(label.name).to eql  'Blocker A'
			expect(label.color).to eql '#FFFFFF'
		end

		it 'should update phase' do
			phase = Phase.find_by_external_id(1065145)
			expect(phase.name).to 			 eql 'Start form A'
			expect(phase.description).to eql 'teste A'
			expect(phase.done).to 			 be_truthy
			expect(phase.pipe_id).to 	   be_present
			expect(phase.index).to 			 eql 0.1
			expect(phase.draft).to 			 be_falsey
		end

		it 'should update card' do
			card = Card.find_by_external_id(1605641)
			expect(card.title).to 	 eql 'Draft a'
			expect(card.index).to 	 eql 0.2
		end

		describe :destroy do
			
			describe 'destroy pipe relation if api did not return' do
				before do
					updater = API::Updater.new('user@fake.com', 'token123')
					updater.stub(:organization).and_return({"id"=>49232,
			   		"name"=>"Pipefy A", "created_at"=>"2017-01-18T12:03:08.274-02:00", "updated_at"=>"2017-01-18T12:04:15.321-02:01",
			   		"pipes"=>[{"id"=>143156, "name"=>"Bug Tracking"}, {"id"=>143185, "name"=>"New Developers Recruitment "}]})
					updater.stub(:pipes).and_return([{
						 "id"=>143156, "name"=>"Bug Tracking","created_at"=>"2017-01-18T12:03:21.345-02:00", "updated_at"=>"2017-01-18T12:03:21.998-02:00",
			 			 "token"=>"abcd", "can_edit"=>true,
						 "users"=>[{"id"=>3599, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"},
						 					 {"id"=>3591, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"}],
						 "labels"=> [{"id"=>594181, "name"=>"Blocker A", "color"=>"#FFFFFF"},{"id"=>594170, "name"=>"Blocker A", "color"=>"#FFFFFF"}],
						 "phases"=>
						  [{"id"=>1065146, "name"=>"Start form A", "description"=>'teste A', "done"=>true, "pipe_id"=>143156, "index"=>0.1, "draft"=>false,
	  						"cards"=>[{"id"=>1605649, "title"=>"Draft a", "current_phase_id"=>1065145, "due_date"=>"2017-01-18T12:04:15.321-02:01", "index"=>0.2}]},
	  					 {"id"=>1065116, "name"=>"Start form A", "description"=>'teste A', "done"=>true, "pipe_id"=>143156, "index"=>0.1, "draft"=>false,
	  						"cards"=>[{"id"=>1605659, "title"=>"Draft a", "current_phase_id"=>1065145, "due_date"=>"2017-01-18T12:04:15.321-02:01", "index"=>0.2}]}]}
				])
					updater.stub(:request!).and_return(true)
					updater.update!
				end

				it 'should delete cards' do
					expect(User.find_by_external_id(3598)).to  	  be_blank
					expect(Label.find_by_external_id(594180)).to  be_blank
					expect(Phase.find_by_external_id(1065145)).to be_blank
					expect(Card.find_by_external_id(1605641)).to  be_blank
					expect(User.find_by_external_id(3591)).to  	  be_present
					expect(Label.find_by_external_id(594170)).to  be_present
					expect(Phase.find_by_external_id(1065116)).to be_present
				end
			end

			describe 'blank cards' do
				before do
					updater = API::Updater.new('user@fake.com', 'token123')
					updater.stub(:organization).and_return({"id"=>49232,
			   		"name"=>"Pipefy A", "created_at"=>"2017-01-18T12:03:08.274-02:00", "updated_at"=>"2017-01-18T12:04:15.321-02:01",
			   		"pipes"=>[{"id"=>143156, "name"=>"Bug Tracking"}, {"id"=>143185, "name"=>"New Developers Recruitment "}]})
					updater.stub(:pipes).and_return([{
						 "id"=>143156, "name"=>"Bug Tracking","created_at"=>"2017-01-18T12:03:21.345-02:00", "updated_at"=>"2017-01-18T12:03:21.998-02:00",
			 			 "token"=>"abcd", "can_edit"=>true,
						 "users"=>[{"id"=>3598, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"}],
						 "labels"=> [{"id"=>594180, "name"=>"Blocker A", "color"=>"#FFFFFF"}],
						 "phases"=>
						  [{"id"=>1065145, "name"=>"Start form A", "description"=>'teste A', "done"=>true, "pipe_id"=>143156, "index"=>0.1, "draft"=>false,
						    "cards"=>[]}]
						}])
					updater.stub(:request!).and_return(true)
					updater.update!
				end

				it 'should delete cards' do
					expect(Card.find_by_external_id(1605641)).to be_blank
				end
			end

			describe 'blank pipes relations' do
				before do
					updater = API::Updater.new('user@fake.com', 'token123')
					updater.stub(:organization).and_return({"id"=>49232,
			   		"name"=>"Pipefy A", "created_at"=>"2017-01-18T12:03:08.274-02:00", "updated_at"=>"2017-01-18T12:04:15.321-02:01",
			   		"pipes"=>[{"id"=>143156, "name"=>"Bug Tracking"}, {"id"=>143185, "name"=>"New Developers Recruitment "}]})
					updater.stub(:pipes).and_return([{
						 "id"=>143156, "name"=>"Bug Tracking","created_at"=>"2017-01-18T12:03:21.345-02:00", "updated_at"=>"2017-01-18T12:03:21.998-02:00",
			 			 "token"=> "abcd", "can_edit"=>true,
						 "users"=>	[],
						 "labels"=> [],
						 "phases"=>	[]
						}])
					updater.stub(:request!).and_return(true)
					updater.update!
				end

				it 'should delete cards' do
					expect(User.all).to  be_blank
					expect(Label.all).to be_blank
					expect(Phase.all).to be_blank
				end
			end
		end

		describe 'destroy pipe if api did not return' do
			before do
				updater = API::Updater.new('user@fake.com', 'token123')
				updater.stub(:organization).and_return({"id"=>49232,
		   		"name"=>"Pipefy A", "created_at"=>"2017-01-18T12:03:08.274-02:00", "updated_at"=>"2017-01-18T12:04:15.321-02:01",
		   		"pipes"=>[{"id"=>143156, "name"=>"Bug Tracking"}, {"id"=>143185, "name"=>"New Developers Recruitment "}]})
				updater.stub(:pipes).and_return([{
					 "id"=>143159, "name"=>"Bug Tracking","created_at"=>"2017-01-18T12:03:21.345-02:00", "updated_at"=>"2017-01-18T12:03:21.998-02:00",
		 			 "token"=>"abcd", "can_edit"=>true,
					 "users"=>[{"id"=>3599, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"},
					 					 {"id"=>3591, "name"=>"user name a", "username"=>"user a", "email"=>"usera@pipefy.com", "display_username"=>"usuario a"}],
					 "labels"=> [{"id"=>594181, "name"=>"Blocker A", "color"=>"#FFFFFF"},{"id"=>594170, "name"=>"Blocker A", "color"=>"#FFFFFF"}],
					 "phases"=>
					  [{"id"=>1065146, "name"=>"Start form A", "description"=>'teste A', "done"=>true, "pipe_id"=>143156, "index"=>0.1, "draft"=>false,
  						"cards"=>[{"id"=>1605649, "title"=>"Draft a", "current_phase_id"=>1065145, "due_date"=>"2017-01-18T12:04:15.321-02:01", "index"=>0.2}]},
  					 {"id"=>1065116, "name"=>"Start form A", "description"=>'teste A', "done"=>true, "pipe_id"=>143156, "index"=>0.1, "draft"=>false,
  						"cards"=>[{"id"=>1605659, "title"=>"Draft a", "current_phase_id"=>1065145, "due_date"=>"2017-01-18T12:04:15.321-02:01", "index"=>0.2}]}]}
			])
				updater.stub(:request!).and_return(true)
				updater.update!
			end

			it 'should delete cards' do
				expect(Pipe.find_by_external_id(143156)).to be_blank
				expect(Pipe.find_by_external_id(143159)).to be_present
			end
		end
	end
end
