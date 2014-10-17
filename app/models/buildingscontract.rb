class Buildingscontract < ActiveRecord::Base
  belongs_to :contract
  belongs_to :building
end
