class Response < ActiveRecord::Base
  belongs_to :participant
  has_and_belongs_to_many :budgets
  has_and_belongs_to_many :date_options

  accepts_nested_attributes_for :budgets
  # accepts_nested_attributes_for :date_options

  def date_option_ids=(date_opt_ids)
    date_options.clear
    date_opt_ids.each do |id|
      date_options << DateOption.find(id)
    end
  end

end
