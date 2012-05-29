class User < ActiveRecord::Base
  has_many :droplets
  has_many :droplet_histories
  
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :password
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end

