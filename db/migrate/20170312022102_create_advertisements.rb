class CreateAdvertisements < ActiveRecord::Migration[5.0]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.decimal :price
      t.string :content
      t.string :preferred_contact
      t.string :location
      t.integer :user_id

      t.timestamps
    end
    add_index :advertisements, [:user_id, :created_at]
  end
end
