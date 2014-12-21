class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  VALID_PHONE_REGEX = /\A[\d]{11}\z/i
  validates :phone, presence: false,
                    format: { with: VALID_PHONE_REGEX }                  

  has_secure_password
  #validates :password, length: { minimum: 6 }
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def User.new_remember_token
    begin
    new_token = SecureRandom.urlsafe_base64
    end while User.exists?(remember_token: User.encrypt(new_token))
    new_token
  end



  enum status: { worker: 0, admin: 1, client: 2 }

  has_many :pairs
  has_many :arrivals
  has_many :requistions, through: :pairs
  has_many :contracts
  belongs_to :boss

  def send_password_reset
    self.update_attribute :password_reset_token, User.new_remember_token
    self.update_attribute :password_reset_sent_at, Time.zone.now
    UserMailer.password_reset(self).deliver
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end  
end
