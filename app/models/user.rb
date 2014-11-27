class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  VALID_PHONE_REGEX = /\A[\d]{11}\z/i
  validates :phone, format: { with: VALID_PHONE_REGEX }                  

  has_secure_password
  validates :password, length: { minimum: 6 }
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  enum status: { worker: 0, admin: 1, client: 2 }

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

  has_many :pairs
  has_many :arrivals
  has_many :requistions, through: :pairs
  has_many :contracts
end
