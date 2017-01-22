class Phase < ApplicationRecord
	belongs_to :pipe
	has_many :cards, dependent: :destroy

end
