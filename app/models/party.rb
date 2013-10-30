class Party < ActiveRecord::Base

	belongs_to :user, dependent: :destroy

	has_many :budgets, :dependent => :destroy
	has_many :date_options, :dependent => :destroy
	has_many :participants, :dependent => :destroy
	
	accepts_nested_attributes_for :budgets, allow_destroy: true
	accepts_nested_attributes_for :date_options, allow_destroy: true
	accepts_nested_attributes_for :participants, allow_destroy: true

	def assign_chief_hen(user)
		self.user = user
		user.chief_hen = true
		user.save
	end
	
end
