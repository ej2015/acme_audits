class AddNullConditionsToAudits < ActiveRecord::Migration[5.1]
  def change
    change_column_null :audits, :auditable_id, false
    change_column_null :audits, :auditable_type, false
  end
end
