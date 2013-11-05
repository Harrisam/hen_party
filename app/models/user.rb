class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :parties
  has_many :contact_details

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  accepts_nested_attributes_for :contact_details
  
end
