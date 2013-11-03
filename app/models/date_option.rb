class DateOption < ActiveRecord::Base
	belongs_to :party
  has_and_belongs_to_many :responses
  has_many :participants, through: :responses
end
