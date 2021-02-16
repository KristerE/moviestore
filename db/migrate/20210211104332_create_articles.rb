class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :article_number
      t.string :name
      t.integer :category
      t.decimal :price
      t.integer :points

      t.timestamps
    end
    add_index :articles, :article_number, unique: true
  end
end
