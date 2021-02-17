class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :verification, null:false
      t.integer :customer_id, defult: 0
      t.integer :amount, null: false
      t.integer :used_points, default: 0
      t.timestamp :created_at

    end
    add_index :orders, :verification, unique: true
  end
end
