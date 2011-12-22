class User < ActiveRecord::Base
  belongs_to :organization
  
  has_many :permissions, :dependent => :destroy
  has_many :pads, :through => :permissions
  has_many :users
  has_many :events
  has_many :messages
  
  attr_accessible :email, :password, :password_confirmation, :user_name, :first_name, :last_name, :organization_id
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create  
  validates_presence_of :email  
  validates_uniqueness_of :email, :scope => :organization_id #unique as combined :email and :organization_id
  validates_presence_of :user_name
  
  def encrypt_password  
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end  
  end
  
  def full_name
    self.first_name + " " + self.last_name
  end
  
  def self.authenticate(subdomain_name, email, password)
    organization = Organization.find_by_subdomain(subdomain_name)
    
    if !organization.nil?
      user = organization.users.find_by_email(email)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)  
        user  
      else
        nil #login failed - incorrect user
      end
    else
      nil #login failed - organization does not exist
    end
  end

  def image
    if !image_name.nil?
      image_name
    else
      "user.jpg"
    end 
  end 

end
