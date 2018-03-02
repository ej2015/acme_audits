FactoryBot.define do
  factory :audit do
    auditable_id 1
    auditable_type 1
    timestamp 1484730623
    event "{\"status\":\"paid\"}"
  end
end
