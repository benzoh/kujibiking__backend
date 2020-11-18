class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.integer :product_id
      t.integer :percentage
      t.string :name

      t.timestamps
    end
  end
end
