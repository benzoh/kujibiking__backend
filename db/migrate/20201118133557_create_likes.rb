class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :target_id
      t.string :target
      t.integer :user_id

      t.timestamps
    end
  end
end
