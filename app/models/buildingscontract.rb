class Buildingscontract < ActiveRecord::Base
  validates :building_id, presence: true
  validates :contract_id, presence: true

  belongs_to :contract
  belongs_to :building
  
end
