class Participant < ActiveRecord::Base
	belongs_to :party
  has_many :budgets, through: :responses
  has_many :date_options, through: :responses

	validates :email, :presence => true
	validates :first_name, :presence => true
	validates :last_name, :presence => true

  before_save :generate_token

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64(32)
  end

end
