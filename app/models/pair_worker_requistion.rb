class PairWorkerRequistion < ActiveRecord::Base
  belongs_to :workers
  belongs_to :requistions
  validates :id_worker, presence: true
  validates :id_requistion, presence: true

end
