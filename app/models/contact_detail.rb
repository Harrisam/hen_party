class ContactDetail < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
end
