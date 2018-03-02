class CreateAudits < ActiveRecord::Migration[5.1]
  def change
    create_table :audits do |t|
      t.integer :auditable_id
      t.integer :auditable_type
      t.bigint :timestamp
      t.json :event

      t.timestamps
    end

    add_index :audits, :auditable_id
    add_index :audits, :auditable_type
    add_index :audits, :timestamp
  end
end
