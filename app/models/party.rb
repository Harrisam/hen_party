class Party < ActiveRecord::Base

	belongs_to :user

	def assign_chief_hen(user)
		self.user = user
		user.chief_hen = true
		user.save
	end
end
