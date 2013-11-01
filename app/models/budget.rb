class Budget < ActiveRecord::Base
	belongs_to :party
  has_many :participants, through: :responses

	validates :amount, :presence => true
end
