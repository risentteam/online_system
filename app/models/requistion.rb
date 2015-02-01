class Requistion < ActiveRecord::Base
  validates :object, presence: true
#  validates :main_address, presence: true
#  validates :arrival_address, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :type_requistion, presence: true

  enum status: { fresh: 0, assigned: 1, adopted_in_work: 2, running: 3, done: 4, completed: 5, canceled: 6}
  

  has_many :pairs
  has_many :users, through: :pairs
  belongs_to :building
  belongs_to :contract
  accepts_nested_attributes_for :pairs


  def cancel(user_id, comment = nil)
    self.time_canceled = Time::now
    self.who_cancel = user_id
    self.status = :canceled
    if comment
      self.requistion_comment = self.requistion_comment + " Причина отмены: " + comment 
    end
    self.save
  end

end