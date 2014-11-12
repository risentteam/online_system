class Requistion < ActiveRecord::Base
  validates :object, presence: true
#  validates :main_address, presence: true
#  validates :arrival_address, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :type_requistion, presence: true

  enum status: { received: 0, done: 1, worker_sended: 2, worker_arrived: 3, worker_gone: 4 }
  #enum status: { получено: 0, сделано: 1, рабочие_отправлены: 2, рабочие_прибыли: 3, рабочие_ушли: 4 }
  has_many :pairs
  has_many :users, through: :pairs
  belongs_to :building
  belongs_to :contract
  accepts_nested_attributes_for :pairs
end
