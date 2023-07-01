class CreateLeases < ActiveRecord::Migration[6.1]
  def change
    create_table :leases do |t|
      t.integer :rent

      t.references :tenant, foreign_key: true
      t.references :apartment, foreign_key: true

      t.timestamps
    end
  end
end
