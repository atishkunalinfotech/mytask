class User < ActiveRecord::Base 
 has_many :tasks
  
  attr_accessor :password
	
  attr_accessible :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_confirmation_of :password
  
  validates_presence_of :password, :on => :create
  
  validates_presence_of :email
  
  validates :email,:presence   => true ,
                                 :format     => {:with => email_regex },
                                 :uniqueness => { :case_sensitive => false}
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => {:within => 6..40}


	before_save :encrypt_password

	def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  def self.authenticate(email, password)
        user = find_by_email(email)
     if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
     else
        nil
     end
  end
    def has_password?(password)
      self.password_salt == self.password_hash
    end
end
