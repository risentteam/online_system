class Building < ActiveRecord::Base
	has_many :requistions
	has_many :buildingscontracts
  	has_many :buildings, through: :buildingscontracts
end