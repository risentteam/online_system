class Contract < ActiveRecord::Base
  belongs_to :user
  has_many :requistions
  has_many :buildingscontracts
  has_many :buildings, through: :buildingscontracts
end
