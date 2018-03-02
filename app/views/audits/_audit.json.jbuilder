json.extract! audit, :id, :auditable_id, :auditable_type, :timestamp, :event, :created_at, :updated_at
json.url audit_url(audit, format: :json)
