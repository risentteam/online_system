class Building < ActiveRecord::Base
	has_many :requistions
	has_many :buildingscontracts
	has_many :contracts, through: :buildingscontracts
	has_many :arrivals

  def name_safe
    name ||  "Нет данных"
  end

  def contact_name_safe
    contact_name ||  "Нет данных"
  end

  def contact_phone_safe
    contact_phone ||  "Нет данных"
  end

end
