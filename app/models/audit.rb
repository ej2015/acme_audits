class Audit < ApplicationRecord
  attr_accessor :file

  enum auditable_type: { customer_order: 0, product: 1, invoice: 2 }

  validates :auditable_id, :auditable_type, presence: true
  
  filterrific(
    available_filters: [
      :with_auditable_type,
      :with_auditable_id,
      :with_timestamp
    ]
  )

  scope :with_auditable_type, lambda { |type|
    where(auditable_type: type)
  }

  scope :with_auditable_id, lambda { |id|
    where(auditable_id: id)
  }

  scope :with_timestamp, lambda { |timestamp|
    where(timestamp: timestamp)
  }

  def self.options_for_auditable_type
    auditable_types.map do |k,v|
      [I18n.t(k, scope: "audits"), v]
    end
  end


end
