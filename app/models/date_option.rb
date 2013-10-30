class DateOption < ActiveRecord::Base
	belongs_to :party, dependent: :destroy
end
