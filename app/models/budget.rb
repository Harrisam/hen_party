class Budget < ActiveRecord::Base
	belongs_to :party
	validates :amount, :presence => true
end
