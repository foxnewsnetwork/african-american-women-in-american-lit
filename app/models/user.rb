require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email , :password , :password_confirmation
  
  email_regex = /\A[a-zA-Z0-9_.-]{1,}@[a-zA-Z0-9_.-]{1,}\.[a-zA-Z]{2,}\z/i
  validates :name , :presence => true ,
                        :length => { :maximum => 64 }
                        
  validates :email , :presence => true ,
                     :format => { :with => email_regex } ,
                     :uniqueness => { :case_sensitive => false }
                     
  validates :password , :presence => true ,
                        :confirmation => true ,
                        :length => { :within => 4..128 }
                        
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    return self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate( email, pass )
    myuser = self.find_by_email( email )
    return nil if myuser.nil?
    return myuser if myuser.has_password?(pass)
  end
  
  def self.authenticate_with_salt( id, cookie_salt )
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
    
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      return secure_hash("#{self.salt}--#{string}")
    end
    
    def make_salt
      return secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      return Digest::SHA2.hexdigest(string)
    end
end
