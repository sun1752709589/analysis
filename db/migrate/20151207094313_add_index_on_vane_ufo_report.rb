class AddIndexOnVaneUfoReport < ActiveRecord::Migration
  def change
    add_index :bulbs, :created_at
  end
end
