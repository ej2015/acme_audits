class Audit < ApplicationRecord
  enum auditable_type: { customer_order: 0, product: 1, invoice: 2 }

  validates :auditable_id, :auditable_type, presence: true
end
