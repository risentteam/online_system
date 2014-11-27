class Boss < ActiveRecord::Base
	VALID_PHONE_REGEX = /\A[\d]{11}\z/i
	validates :phone, format: { with: VALID_PHONE_REGEX }
end
