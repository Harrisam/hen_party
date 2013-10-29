class Party < ActiveRecord::Base
	has_many :budgets
	accepts_nested_attributes_for :budgets
end
