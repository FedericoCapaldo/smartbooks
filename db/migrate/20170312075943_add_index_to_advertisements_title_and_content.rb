class AddIndexToAdvertisementsTitleAndContent < ActiveRecord::Migration[5.0]
  def change
    add_index :advertisements, [:title, :content]
  end
end
