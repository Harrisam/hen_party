class Party < ActiveRecord::Base
	has_many :budgets
	has_many :date_options
	accepts_nested_attributes_for :budgets
	accepts_nested_attributes_for :date_options
end
