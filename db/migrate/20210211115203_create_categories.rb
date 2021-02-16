class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.integer :category
      t.string :name
      t.decimal :default_price
      t.integer :points

      t.timestamps
    end
  end
end
