class CreateVankeBulbHouseTables < ActiveRecord::Migration
  def change
    create_table :vanke_device_house_tables do |t|
      t.integer :device_id
      t.string :device_type
      t.integer :house_id

      t.timestamps null: false
    end
  end
end
