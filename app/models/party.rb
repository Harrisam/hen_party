class Party < ActiveRecord::Base

	belongs_to :user, dependent: :destroy

	has_many :budgets, :dependent => :destroy
	has_many :date_options, :dependent => :destroy
	has_many :participants, :dependent => :destroy
	
<<<<<<< HEAD
	accepts_nested_attributes_for :budgets, allow_destroy: true, reject_if: lambda {|attributes| attributes['amount'].blank?}
	accepts_nested_attributes_for :date_options, allow_destroy: true, reject_if: lambda {|attributes| attributes['start_date'].blank?}
	accepts_nested_attributes_for :participants, allow_destroy: true, reject_if: lambda {|attributes| attributes['email'].blank?}
=======
	accepts_nested_attributes_for :budgets, allow_destroy: true
	accepts_nested_attributes_for :date_options, allow_destroy: true
	accepts_nested_attributes_for :participants, allow_destroy: true
>>>>>>> 20432586578cb33c1dd0b576ca55f479ddc075b2

	def assign_chief_hen(user)
		self.user = user
		user.chief_hen = true
		user.save
	end
	
end
