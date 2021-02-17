class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.integer :points, defult: 0

      t.timestamps
    end
  end
end
