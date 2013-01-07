class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :price
      t.text :description
      t.text :details
      t.string :brand
      t.string :model_number
      t.string :external_id
      t.string :external_url
      t.string :external_provider

      t.timestamps
    end
    add_index :products, :title
    add_index :products, :price
    add_index :products, :external_id
    add_index :products, :external_provider
  end
end
