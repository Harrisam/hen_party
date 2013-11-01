class Response < ActiveRecord::Base
  belongs_to :participant
  has_and_belongs_to_many :budgets
  has_and_belongs_to_many :date_options
end
