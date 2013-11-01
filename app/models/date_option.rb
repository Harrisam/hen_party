class DateOption < ActiveRecord::Base
	belongs_to :party
  has_many :participants, through: :responses
end
