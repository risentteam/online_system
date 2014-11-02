class Arrival < ActiveRecord::Base
	belongs_to :user
	belongs_to :building
	enum check_type: { check_in: 0, check_out: 1}
end
