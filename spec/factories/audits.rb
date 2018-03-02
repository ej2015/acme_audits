FactoryBot.define do
  factory :audit do
    auditable_id 1
    auditable_type 1
    timestamp ""
    event ""
  end
end
