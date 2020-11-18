class CreateApplies < ActiveRecord::Migration[6.0]
  def change
    create_table :applies do |t|
      t.integer :product_id
      t.string :result
      t.integer :poind_id
      t.string :image
      t.string :memo
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
