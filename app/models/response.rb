class Response < ActiveRecord::Base
  belongs_to :participant
  has_and_belongs_to_many :budgets
  has_and_belongs_to_many :date_options

  def date_option_ids=(date_option_ids)
    date_options.clear
    date_option_ids.each do |id|
      self.date_options << DateOption.find(id)
    end
  end

  def budget_option_ids=(budget_option_ids)
    budgets.clear
    budget_option_ids.each do |id|
      self.budgets << Budget.find(id)
    end
  end

end
