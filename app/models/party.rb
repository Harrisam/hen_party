class Party < ActiveRecord::Base

	belongs_to :user

	has_many :budgets
	has_many :date_options
	has_many :participants
	
	accepts_nested_attributes_for :budgets
	accepts_nested_attributes_for :date_options
	accepts_nested_attributes_for :participants

	def assign_chief_hen(user)
		self.user = user
		user.chief_hen = true
		user.save
	end
	
end
