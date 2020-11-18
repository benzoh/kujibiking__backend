class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.string :url
      t.integer :category_id
      t.string :slug

      t.timestamps
    end
  end
end
