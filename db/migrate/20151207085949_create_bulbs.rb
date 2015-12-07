class CreateBulbs < ActiveRecord::Migration
  def change
    create_table :bulbs do |t|
      t.integer :device_ip
      t.string :op_code
      t.string :instruction
      t.string :care_word
      # t.timestamp :generated_at
      t.string :message

      t.timestamps null: false
    end
  end
end
