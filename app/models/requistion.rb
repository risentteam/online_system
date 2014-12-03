class Requistion < ActiveRecord::Base
  validates :object, presence: true
#  validates :main_address, presence: true
#  validates :arrival_address, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :type_requistion, presence: true

  enum status: { fresh: 0, assigned: 2, adopted_in_work: 4, running: 6, done: 8, comleted: 10}
  #enum status: { получено: 0, сделано: 1, рабочие_отправлены: 2, рабочие_прибыли: 3, рабочие_ушли: 4 }
  has_many :pairs
  has_many :users, through: :pairs
  belongs_to :building
  belongs_to :contract
  accepts_nested_attributes_for :pairs
end