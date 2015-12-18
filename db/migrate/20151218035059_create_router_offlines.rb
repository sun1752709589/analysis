class CreateRouterOfflines < ActiveRecord::Migration
  def change
    create_table :router_offlines do |t|
      t.integer :device_ip
      t.string :msg

      t.timestamps null: false
    end
  end
end
