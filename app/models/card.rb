class Card < ApplicationRecord
	belongs_to :phase
  has_many :field_values, dependent: :destroy
end
