class Pipe < ApplicationRecord
	belongs_to :organization
	has_many :users, dependent: :destroy
	has_many :phases, dependent: :destroy
	has_many :labels, dependent: :destroy

	accepts_nested_attributes_for :users, :phases, :labels, allow_destroy: true

end
