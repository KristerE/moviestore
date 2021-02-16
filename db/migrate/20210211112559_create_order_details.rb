class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.string :verification
      t.integer :article_number
      t.string :name
      t.integer :category
      t.integer :price
      t.integer :points

    end
  end
end
