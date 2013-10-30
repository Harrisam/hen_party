class Participant < ActiveRecord::Base
	belongs_to :party
	validates :email, :presence => true
	validates :first_name, :presence => true
	validates :last_name, :presence => true

  before_save :generate_token

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64(32)
  end

end
